* Install postgres brew install postgresql
 - Link issue https://stackoverflow.com/questions/27700596/homebrew-postgres-broken

* create rails app rails new gisonrails --api --database=postgresql

* .ruby-version .ruby-gemset

* gem install bundler

* brew install postgis

* add gem 'activerecord-postgis-adapter'

* create database rake db:create

* psql database => database=# CREATE EXTENSION postgis;

* create place model and controller
	Migration example: 
	class CreatePlaces < ActiveRecord::Migration[5.1]
	  def change
	    create_table :places do |t|
	      t.string :name
	      t.st_point :lonlat, geographic: true

	      t.timestamps
	    end
	  end
	end

* Test your endpoint 
	curl -X POST -H "Content-Type: application/json" "localhost:3000/places" -d '{"name": "test2", "lonlat": "POINT(53.551086 9.993682)"}'

* download heroku cli and inititalize project
	https://devcenter.heroku.com/articles/getting-started-with-rails4

* add postgis addon
	$ heroku pg:psql
	create extension postgis;

* configure database.yml to work with postgis on heroku
	production:
	  <<: *default
	  database: gisonrails_production
	  username: gisonrails
	  password: <%= ENV['GISONRAILS_DATABASE_PASSWORD'] %>
	  schema_search_path: public, postgis
  	  url: <%= ENV.fetch('DATABASE_URL', '').sub(/^postgres/, "postgis") %>

	https://stackoverflow.com/questions/32710406/enabling-ruby-postgis-support-on-heroku

