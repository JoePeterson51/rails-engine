# Rails Engine

## About this Project
Rails Engine is a project that exposes data that powers a mock E-Commerce Application site through an API that the front end will consume using service-oriented architecture for building the API.

## Table of Contents

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Authors](#authors)

## Getting Started

To run the web application on your local machine, you can fork and clone down the repo and follow the installation instructions below.


### Installing

- Install the gem packages
`bundle install`

- Create the database by running the following command in your terminal
`rails db{:drop,:create,:migrate,:seed}`

### Prerequisites

To run this application you will need Ruby 2.7.2 and Rails 5.2.6

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected
`bundle exec rspec`

Postman can also be used for testing by following the instructions found [here](https://backend.turing.edu/module3/projects/rails_engine/)

## DB Schema
The following is a depiction of our Database Schema

 ![Rails Engine Schema](assets/README-f3a799e1.png)

## API Endpoints

### Items
- `GET /api/v1/items/find?name=<query>` Find one item based on name search
- `GET /api/v1/items/find_all?name=<query>` Find all items that match a name search
- `GET /api/v1/items` Returns all items
- `POST /api/v1/items` Create an Item
- `GET /api/v1/item/:id` Get one Item by id
- `PATCH /api/v1/items/:id` Edit an Item
- `DELETE /api/v1/items/:id` Delete an Item
- `GET /api/v1/items/:id/merchant` Get the Merchant data for a given Item ID

### Merchants
- `GET /api/v1/merchants/find?name=<query>` Find one merchant based on name search
- `GET /api/v1/merchants/find_all?name=<query>` Find all merchants that match a name search
- `GET /api/v1/merchants/most_items?quantity=<query>` Find the quantity of merchants with the most items sold
- `GET /api/v1/merchants` Returns all merchants
- `GET /api/v1/merchant/:id` Get one merchant by id
- `GET /api/v1/merchants/:id/items` Get all Items for a given Merchant ID

### Revenue
- `GET /api/v1/revenue/merchants?quantity=<query>` Find the quantity of merchants with the highest revenue
- `GET /api/v1/revenue/merchants/:id` Find the total revenue for a given merchant
- `GET /api/v1/revenue?start=<start_date>&end=<end_date>` Find the total revenue for a specific time span
- `GET /api/v1/revenue/items?quantity=<query>` Find the quantity of items that have the top revenue
- `GET /api/v1/revenue/unshipped?quantity=<x>` Find the potential revenue for the quantity given for items that are unshipped

### Pagination
- `GET /api/v1/merchants?per_page=50&page=2` Get all merchants with quantity per page and/or page number.
- `GET /api/v1/items?per_page=50&page=2` Get all Items with quantity per page and/or page number.

## Built With
- Ruby
- Rails
- RSpec

## Gems Used
- factory_bot_rails
- faraday
- faker
- jsonapi-serializer

## Versioning
- Ruby 2.7.2
- Rails 5.2.6

## Authors
- **Joe Peterson**
| [GitHub](https://github.com/JoePeterson51) |
  [LinkedIn](https://www.linkedin.com/in/joe-peterson-14718220b/)
