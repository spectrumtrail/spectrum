# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

Upon cloning this repository and running: 
```
docker-compose up --build
``` 
You will need to create the database. This only needs to happen the first time you clone the repo to ensure you have the database. It would only need to happen again if you delete the database.

From the terminal perform the following
```
docker-compose exec -it spectrum_app /bin/sh
rake db:create
```

This will create the new database **spectrum_development**.

* Database initialization

After the database is created run the following command.
```
/usr/local/bundle/bin/rails db:migrate RAILS_ENV=development
```
This command shoudl run on any rebuilds of the image after the database is initially created int eh steps above.

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Notes and References

https://stackoverflow.com/questions/25538171/stripe-rails-environmental-variables
