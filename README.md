Sinatra Template
================
Template for medium-sized applications based on Sinatra.

It's inspired by Rails as it's a well-known structure - but it's NOT Rails! ;)

Application name
----------------
To avoid polluting global namespaces, everything is packed inside a `MyApp` module, so you may consider renaming the `MyApp` module stored in `init.rb` and its derivatives:

- `MyApp::Controllers` in `init.rb` and `app/controllers.rb`
- `MyApp::Helpers` in `init.rb` and `app/helpers.rb`
- `MyApp::Application` in `config.ru`, `test/test_helper.rb` and `features/support/env.rb`

Configuring the application
---------------------------
The template reads the app config from `config/config.yml` in the `initialize` method at `init.rb`.

Start
-----
Start the application in the port 4567 with:

    rackup -p 4567

You can set the environment mode in `config.ru` with 

    ENV['RACK_ENV'] = 'deployment'

Adding helper or controller files
---------------------------------
You can create a `app/helpers` directory with modules inside and include all of them into the current helpers module at `app/helpers.rb`.
The same applies for controllers.

Testing
-------
If you don't test your apps _(which is a bad thing, TAFT FTW!)_ feel free to delete `features` and `test` directories.

The template includes ready to use helpers to start testing your application with Test::Unit and Cucumber. Both of them make the Rack::Test available in your tests.

It also includes working examples, which could be useful as a starting point.

Disclaimer: I'm learning Cucumber, if you have any suggestions please let me know.

License
-------
[Raul Murciano](http://raul.murciano.net) Copyright (c) 2009 Released under the MIT license (see MIT-LICENSE)

Credits
-------
This is a mere bunch of files and dirs, actual credits correspond to the awesome brains behind Sinatra and Rack projects. 

Thank you very very very much to all of them!!!