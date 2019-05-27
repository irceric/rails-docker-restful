# README

How to run & test application

I use docker for this test app.

## To run app

- docker-compose build
- docker-compose up

## To run migration

- docker-compose run web rake db:create
- docker-compose run web rake db:migrate

## To see the routes

- docker-compose run web rails routes

## To run Rspec

- docker-compose run web bundle exec rspec
