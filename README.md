# Tea Subscription Service 

## Overview
Welcome to the Tea Subscription Service. This is a Ruby on Rails API application allows a client to make API calls to endpoints that:
* enable a customer to subscribe to a tea subscription
* allow a customer to canel a tea subscription
* retrieve all of a customer's subscriptions (both active and cancelled).
Further details about the applications JSON response, endpoints, dependencies, and other general configuration information can be found below. 

## Endpoints and JSON Contract
The Tea Subscription Service API has three endpoints. 

### `Subscribe a customer to a tea subscription`

### `Cancel a customer’s tea subscription`

### `See all of a customer’s subsciptions (active and cancelled)`

## Database and Schema 
The database and schema for the Tea Subscription Service API is listed below. 
<img width="736" alt="Screenshot 2024-10-05 at 8 44 20 AM" src="https://github.com/user-attachments/assets/6db24780-3e4c-4090-a063-24060010a3d8">

## General Information 

* API version: version one (V1)

* Ruby version: Ruby 3.2.2

* Rails version: Rails 7.1.4

* Installing dependencies: This application utilizes a number of ruby gems. The application to run properly, upoon opening the application and navigating to its directory in the file path, run the following command from the terminal `bundle install`. This will install all required gems. 

* Database creation: To create the database for this application, run the following command in the terminal while in the application directory `rails db:create`.

* Database initialization: To initialize the database for this application, run the following command in the terminal while in the application directory `rails db:migrate`.

* How to run the test suite: To run the test suire for this application, run the following command in the terminal while in the application directory `bundle exec rspec spec`. If you would like to run only particular tests within the larger spec directory add those after spec as though you were navigating through the file structure. For example, `bundle exec rspec spec/requests`.

* Deployment instructions
