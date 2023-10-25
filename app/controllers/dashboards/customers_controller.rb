# frozen_string_literal: true

class Dashboards::CustomersController < ApplicationController
  include DashboardLayout

  def index
    query = <<~SQL
      SELECT DISTINCT users.id,
                      users.first_name,
                      users.last_name,
                      COUNT(reviews.id)                                        AS reviews_count,
                      CASE WHEN COUNT(reviews.id) > 4 THEN TRUE ELSE FALSE END AS is_regular,
                      latest_review.description                                AS latest_description,
                      latest_review.rating                                     AS latest_rating,
                      latest_avg_review.avg_rating                             AS average_rating
      FROM users
               INNER JOIN reviews ON users.id = reviews.user_id
               -- Latest review subquery
               LEFT JOIN (SELECT user_id, MAX(created_at) AS latest_review_created_at
                          FROM reviews
                          WHERE business_id = :business_id
                          GROUP BY user_id) AS latest_review_subquery ON users.id = latest_review_subquery.user_id
               -- Latest reviews
               LEFT JOIN reviews AS latest_review ON latest_review_subquery.user_id = latest_review.user_id
          AND latest_review_subquery.latest_review_created_at = latest_review.created_at
               -- Average rating
               LEFT JOIN (SELECT user_id, AVG(rating) AS avg_rating
                          FROM reviews
                          WHERE business_id = :business_id
                          GROUP BY user_id) AS latest_avg_review ON users.id = latest_avg_review.user_id
      WHERE reviews.business_id = :business_id
      GROUP BY users.id, users.first_name, users.last_name, latest_review.description, latest_review.rating,
               latest_avg_review.avg_rating
      ORDER BY reviews_count DESC
    SQL

    params = {
      business_id: current_client.business.id
    }
    @reviewers = ActiveRecord::Base.connection.execute(
      ApplicationRecord.sanitize_sql([query, params])
    )
    @reviewers_count = 0
    @anon_reviews = current_client.business.anon_reviews
  end
end
