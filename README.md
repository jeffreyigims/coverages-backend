# README

# Coverages Project

## Description 
This application encapsulates the backend support for the coverages project. The application is built on Ruby on Rails and is structured as an API. Cross-origin resource is sharing is allowed and security is handled by JSON web token authentication. Most data is serialized before being sent to the front-end application with the use of 'fast_json' gem.

## Data Populating
To populate the database simply run ```ruby rails db:populate ```. There are multiple methods to populate the data. To view the methods, navigate to lib/tasks/helper/helper.rb and to specify a method to be called, navigate to lib/tasks/populate.rake and uncomment out the preferred method.

## Deployment 
The application is currently deployed on Heroku at the following link: https://dashboard.heroku.com/apps/coverages-backend. 
There are no add-ons required; however, for deployment to work the following must be included in the knock.rb initializer file: ```ruby config.token_secret_signature_key = -> { Rails.application.secret_key_base } ``` instead of ```ruby config.token_secret_signature_key = -> { Rails.application.credentials.fetch(:secret_key_base) } ``` which is for local use. Heroku must configure a variable to represent the key base to accompany the code. This is all to complement the 'knock' gem which allows for JSON web token authentication.
