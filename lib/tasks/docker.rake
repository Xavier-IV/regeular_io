# frozen_string_literal: true

namespace :docker do
  desc 'Push Docker image to AWS ECR'
  task push: :environment do
    # Define the path to your push-image.sh script
    script_path = 'deploy/docker/scripts/push-image.sh'

    # Run the script using the sh command
    sh script_path
  end
end
