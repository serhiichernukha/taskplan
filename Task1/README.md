# Onboarding plan

**Full name**: Serhii Chernukha

**Job position**: DevOps Engineer
___
Task  | Deadline
------------- | -------------
2.Docker  | 10.2.2020/14.2.2020

### Task 2

Know how to work with **Docker**. Be able to Dockerize any
application: **Ruby, PHP, Python, Java**. Select any available
free web apps based on each technology and dockerize
them. **Expected result**: docker-compose files for each
application type. Applications should be accessible and
work as expected (or described).

___

## AGENDA

  - Deploy Ruby Application
  - Deploy PHP Application
  - Deploy Python Application
  - Deploy Java Application

___

# Deploy Ruby Application

### Define the project

Start by setting up the files needed to build the app. App will run inside a **Docker** container containing its dependencies. Defining dependencies is done using a file called Dockerfile. To begin with, the ```Dockerfile``` consists of:

```
FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
```

That’ll put application code inside an image that builds a container with Ruby, Bundler and all dependencies inside it.

Next, create a bootstrap ```Gemfile``` which just loads Rails. It’ll be overwritten in a moment by ```rails new```.

```
source 'https://rubygems.org'
gem 'rails', '~>5'
```

Create an empty ```Gemfile.lock``` to build our ```Dockerfile```.

```
touch Gemfile.lock
```

Next, provide an entrypoint script to fix a Rails-specific issue that prevents the server from restarting when a certain ```server.pid``` file pre-exists. This script will be executed every time the container gets started. ```entrypoint.sh``` consists of:

```
#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
```

Finally, ```docker-compose.yml``` is where the magic happens. This file describes the services that comprise your app (a database and a web app), how to get each one’s Docker image (the database just runs on a pre-made PostgreSQL image, and the web app is built from the current directory), and the configuration needed to link them together and expose the web app’s port.

```
version: '2'
services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data
  web:
    build: .
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/myapp
    ports:
      - "3000:3000"
    depends_on:
      - db
```

### Build the project

With those files in place, you can now generate the Rails skeleton app using ```docker-compose run```:

```
docker-compose run web rails new . --force --no-deps --database=postgresql
```

![](https://i.paste.pics/cda866f867657a96ca5e3684f43bd267.png?trs=f6009fac31c07e6ac9e276bf728abce1f2845bf446fb75be32daf440558621e0)

First, Compose builds the image for the ```web``` service using the ```Dockerfile```. Then it runs ```rails new``` inside a new container, using that image. Once it’s done, you should have generated a fresh app.

List the files.
![](https://i.paste.pics/4e85b39604949a561a980d199af9d85c.png?trs=f6009fac31c07e6ac9e276bf728abce1f2845bf446fb75be32daf440558621e0)

We are running Docker on Linux, the files rails new created are owned by root. This happens because the container runs as the root user. If this is the case, we should change the ownership of the new files.

```
sudo chown -R $USER:$USER .
```

Now that we’ve got a new Gemfile, we need to build the image again. (This, and changes to the Gemfile or the Dockerfile, should be the only times we’ll need to rebuild.)

```
docker-compose build
```

![](https://i.paste.pics/8ce1709bf0ce28d09a376bc850446228.png?trs=f6009fac31c07e6ac9e276bf728abce1f2845bf446fb75be32daf440558621e0)

### Connect the database

The app is now bootable, but we’re not quite there yet. By default, Rails expects a database to be running on ```localhost``` - so we need to point it at the ```db``` container instead. We also need to change the database and username to align with the defaults set by the ```postgres``` image.

Replace the contents of ```config/database.yml``` with the following:

```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
```

![](https://i.paste.pics/79f3950cfa895c73c9e8d146e2f97d60.png?trs=f6009fac31c07e6ac9e276bf728abce1f2845bf446fb75be32daf440558621e0)

We can now boot the app with ```docker-compose up```:

```
docker-compose up
```

Finally, we need to create the database. In another terminal, run:

```
docker-compose run web rake db:create
```
