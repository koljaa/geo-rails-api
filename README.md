# Install postgres brew install postgresql

Link issue https://stackoverflow.com/questions/27700596/homebrew-postgres-broken

# Install PostGis

brew install postgis

# Create a rails api only app

create rails app rails new gisonrails --api --database=postgresql

# Set the ruby-version and gemset

.ruby-version .ruby-gemset

# Install Bundler and add required gems to gemfile 

	gem install bundler

Add activerecord-postgis-adapter in your gemfile. https://github.com/rgeo/activerecord-postgis-adapter

	gem 'activerecord-postgis-adapter' 

# Create the databases locally and enable PostGis extension

create database rake db:create
psql database => database=# CREATE EXTENSION postgis;

# Build your API. For example start with a places endpoint.

Example migration with geo enable field lonlat:

	class CreatePlaces < ActiveRecord::Migration[5.1]
	  def change
	    create_table :places do |t|
	      t.string :name
	      t.st_point :lonlat, geographic: true
	      t.timestamps
	    end
	  end
	end

# Test your endpoint 

	curl -X POST -H "Content-Type: application/json" "localhost:3000/places" -d '{"name": "test2", "lonlat": 		"POINT(53.551086 9.993682)"}'

# Prepare deployment on Heroku

##Download heroku cli tool and inititalize project

https://devcenter.heroku.com/articles/getting-started-with-rails4

## Add postgis addon

	$ heroku pg:psql
	create extension postgis;

##Cconfigure database.yml to work with postgis on heroku

	production:
	  <<: *default
	  database: gisonrails_production
	  username: gisonrails
	  password: <%= ENV['GISONRAILS_DATABASE_PASSWORD'] %>
	  schema_search_path: public, postgis
  	  url: <%= ENV.fetch('DATABASE_URL', '').sub(/^postgres/, "postgis") %>

https://stackoverflow.com/questions/32710406/enabling-ruby-postgis-support-on-heroku

