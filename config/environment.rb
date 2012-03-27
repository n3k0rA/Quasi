# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Quasi::Application.initialize!

#Needed to run S3 in European servers
AWS::S3::DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"