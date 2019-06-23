# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.config.middleware.use JQuery::FileUpload::Rails::Middleware
Rails.application.initialize!
