Sinatra Template
================
Template for medium-sized applications based on Sinatra.

It's inspired by Rails as it's a well-known structure - but it's NOT Rails! ;)

Application name
----------------
To avoid polluting global namespaces, everything is packed inside a `MyApp` module, so you may consider renaming the `MyApp` module stored in `init.rb` and its derivatives:

- `MyApp::Controllers` in `init.rb` and `app/controllers.rb`
- `MyApp::Helpers` in `init.rb` and `app/helpers.rb`
- `MyApp::Application` in `config.ru` and `test/test_helper.rb`

Database connection should be configured in `init.rb` from the `CONFIG` configuration, which is read from `config/config.yml`

Start
-----
Start the application in the port 4567 with:

    rackup -p 4567

You can set the environment mode in `config.ru` with 

    ENV['RACK_ENV'] = 'deployment'

Adding helper or controller files
---------------------------------
You can create a `app/helpers` directory with modules inside and include all of them into the current helpers/controller module.

License
-------
Raul Murciano http://murciano.net

Copyright (c) 2009 Released under the MIT license (see MIT-LICENSE)

Credits
-------
This is a mere bunch of files and dirs, actual credits correspond to the awesome brains behind Sinatra and Rack projects. 

Thank you very very very much to all of them!!!