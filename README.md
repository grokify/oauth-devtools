OAuth DevTools
==============

This app provides a set of OAuth development tools.

The initial functionality includes development tools to retrieve access tokens from 3-legged OAuth services.

The access token and other information will be written into the dotenv `.env` file which can then be read by other apps.

This code was originally forked from a demo script in the RingCentral Ruby SDK.

Supported services include:

* [x] Dropbox

## Prerequisites :warning:

* Ruby
* Ruby Gems

## Installation

```sh
$ git clone https://github.com/grokify/oauth-devtools
$ cd oauth-devtools
$ bundle install
```

## Configuration

Ensure you are in the `oauth-devtools/app` directory and then create / edit the `.env` file. Ensure that your OAuth redirect URI matches the one specified in your app configuration page.

```sh
$ cd app
$ cp sample.env .env
$ vim .env
```

## Usage

Ensure you are in the `oauth-devtools/app` directory and then run `app.rb`.

```sh
$ cd oauth-devtools/app
$ ruby app.rb
``` 

Then navigate your browser to the URL presented, e.g. `http://localhost:4567`.

## Contributing

1. Fork it ( http://github.com/grokify/oauth-devtools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

OAuth DevTools is available under an MIT-style license. See [LICENSE.txt](LICENSE.txt) for details.

OAuth DevTools &copy; 2015-2016 by John Wang
