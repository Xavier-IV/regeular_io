# frozen_string_literal: true

class BusinessPolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    super
    @user = user
    @article = article
  end

  def index?
    true
    # if set to false - no one will have access
  end

  def show?
    true
  end

  # Same as for create
  def new?
    create?
  end

  # Same as that of the update.
  def edit?
    update?
  end

  # Only admin is allowed to update the article and only if article is not published
  def update?
    user.admin?
  end

  # Only admin is allowed to create the article.
  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
