# README

# Coverages Project

## Description 
This application encapsulates the backend support for the coverages project. The application is built on Ruby on Rails and is structured as an API. Cross-origin resource is sharing is allowed and security is handled by JSON web token authentication. Most data is serialized before being sent to the front-end application with the use of 'fast_json' gem.

## Data Populating
To populate the database simply run ```ruby rails db:populate ```. There are multiple methods to populate the data. To view the methods, navigate to lib/tasks/helper/helper.rb and to specify a method to be called, navigate to lib/tasks/populate.rake and uncomment out the preferred method.

## Deployment 
The application is currently deployed on Heroku at the following link: https://dashboard.heroku.com/apps/coverages-backend. 
There are no add-ons required; however, for deployment to work the following must be included in the knock.rb initializer file: ```ruby config.token_secret_signature_key = -> { Rails.application.secret_key_base } ``` instead of ```ruby config.token_secret_signature_key = -> { Rails.application.credentials.fetch(:secret_key_base) } ``` which is for local use. Heroku must configure a variable to represent the key base to accompany the code. This is all to complement the 'knock' gem which allows for JSON web token authentication.

## Parameters
The code is structured like a typical API, with the models being responsible for maintaining the data and the contollers tasked with responding to the requests of the client. The controllers include helper modules to assist with filtering and ordering the data when a request is made with parameters. For instance, if a user requests all coverages that are verified, ordered by most recently entered, they will pass the parameters: ```ruby verified: true ``` and ```ruby most_recent: true ```. These are representative of scopes in the coverage model which are called by the controller. To include new parameters for the client to include and the API to respond to, simply create a scope in the model and add the symbol to the list of acceptable params at the top of the specific controller.

## Serialization
Serialization is handled with the help of the fast_json gem. Serializers are located in the serializers folder. To create a new structure or change the existing serialization, navigate to app/serializers and create a new file with the name of the file matching the desired name of the serializer. Then create a new class to handle the serialization. For more reference on how to serialize in the class see existing serializers or review the documentation: https://github.com/Netflix/fast_jsonapi.
