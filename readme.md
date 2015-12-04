# RDregister
[![Coverage Status](https://coveralls.io/repos/WilliamGrah/rdregister/badge.svg?branch=master&service=github)](https://coveralls.io/github/WilliamGrah/rdregister?branch=master)

## Getting Started
1. First of all, you need ruby installed in your enviroment.
If you don't know how to install ruby, for a full list of ways to install ruby:

        http://www.ruby-lang.org/en/downloads/

2. You will need to install some requirements:

        $ sudo apt-get install postgresql postgresql-contrib sqlite3 nodejs

3. clone the project, enter in the project folder and run:

        $ bundle install

    if you experience anykind of error with gem 'pg' you can run bundle like this:

        $   bundle install --without=production

4. now you need to run the migrations:

        $ rake db:migrate

5. this step is optional, you can fill your db with some random data:

        $ rake db:seed

6. Now just put the server up:

        $ rails server

If you see something like that:

    => Booting WEBrick
    => Rails 4.2.5 application starting in development on http://localhost:3000
    => Run `rails server -h` for more startup options
    => Ctrl-C to shutdown server
    [2015-12-02 18:41:47] INFO  WEBrick 1.3.1
    [2015-12-02 18:41:47] INFO  ruby 2.2.0 (2014-12-25) [x86_64-linux]
    [2015-12-02 18:41:47] INFO  WEBrick::HTTPServer#start: pid=31282 port=3000

### Well done, everything is running ok.

### To access the list of contacts
    http://localhost:3000/contacts
### To register a new contact
    http://localhost:3000


## if you wanna see the application runnning:
http://rdregister.herokuapp.com