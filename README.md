# Skedge

Event planner and subscription.

## Getting Started - Local Development

The Skedge web application is built using Ruby, Ruby on Rails and PostgreSQL. It
uses Foreman to run locally as close to production as possible.

It uses the Phusion Passenger web server, and it hosted on Heroku.

### 1. Clone the project.

```
$ cd ~/your-dev-folder
$ git clone git@github.com:rivercodi/skedge.git
```

### 2. Install node dependencies.

```
$ npm install
```

### 3. Install ruby dependencies.

```
$ gem install bundler foreman
$ bundle install
```

### 4. Confgure environment files.

```
$ touch .env
$ touch config/application.yml
```

### 5. Add environment variables. Paste this into your .env file as a placeholder.

```
FACEBOOK_KEY=key
FACEBOOK_SECRET=key
TWITTER_KEY=key
TWITTER_SECRET=key
```

### 6. Paste this into your config/application.yml file.

```
FACEBOOK_KEY: 'key'
FACEBOOK_SECRET: 'key'
TWITTER_KEY: 'key'
TWITTER_SECRET: 'key'
```

### 7. Create the database.

```
$ rake db:create
$ rake db:migrate
```

### 8. Run rspec to make sure everything is set up properly.

```
$ rspec
```

### 9. Start the ruby server.

```
$ foreman start
```
