# Evaweb

[![Ruby CLI CI Status](https://github.com/orsa-scholis/evaweb/workflows/Rails/badge.svg)](https://github.com/orsa-scholis/evaweb/actions)

A survey tool with live statistics and simple survey submission

### Prerequisites

1.  Install Ruby, preferably with rbenv: `rbenv install 2.6.6`
    
2.  Install PostgreSQL
    
3.  Install Redis if you want production behaviour
    

## Setup

1.  Clone Repository `git clone https://github.com/orsa-scholis/evaweb.git`
    
2.  Switch working directory `cd evaweb`
    
3.  Run `bin/setup`
    

### Development

Processes:

-   Development Rails Server: `rails server`
    
-   Webpack Server: `bin/webpack-dev-server`
    
-   Worker: `bundle exec sidekiq -C config/sidekiq.yml`
    

You can also use a tool like foreman or procodile to start all services at once, specified in `Procfile`.

Before running a new version, call `bin/rails db:migrate`.

The tool is tested using RSpec and coverage is set to 100%

### Deployment

The live version is deployed to Heroku. To production environment, a Postgres and Redis container should be attached. Be sure to configure all environment variables required, which are listed in `config/application.example.yml`

Development deployment: https://evaweb-develop.herokuapp.com
Production deployment: https://evaweb-production.herokuapp.com

Required Add-Ons:

- Redis
- Postgres
- Some mail service e.g. Sendgrid or Sparkpost
- Optionally Papertrail
