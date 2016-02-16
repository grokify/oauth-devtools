OAuth DevTools
==============

This app provides a set of OAuth development tools.

It includes a web server that performs OAuth 2.0 with services and then writes the retrieved access token to the file system in a dotenv `.env` file so that it can be easily used by applications during development.

### Benefits

This is beneficial because some services only support 3-legged OAuth which requires a webserver and redirection. In development mode, some of these services recommend generating an access token via a webpage and copy / pasting that into an app which can be cumbersome so this app streamlines this process.

1. Eliminates need to copy and paste access token in development by storing the access token in a program accessible file system location
1. Provides example code for production OAuth with redirection when [some SDK tutorials](https://www.dropbox.com/developers-v1/core/start/ruby) do not

### Integrations

Currently, only Dropbox is supported, but as services are added, each will have information prefixed by the service name.

Supported services include:

| Service | Input Variables | Output Variables |
|---------|-----------------|------------------|
| Dropbox | `DROPBOX_APP_KEY`, `DROPBOX_APP_SECRET`, `DROPBOX_OAUTH2_REDIRECT_URI` | `DROPBOX_ACCESS_TOKEN` |

## Prerequisites :warning:

* [Ruby](https://www.ruby-lang.org/) / [RubyGems](https://rubygems.org/)

## Installation

Install [Bundler](http://bundler.io/) if necessary:

```sh
$ gem install bundler
```

Install app and required gems:

```sh
$ git clone https://github.com/grokify/oauth-devtools
$ cd oauth-devtools
$ bundle install
```

## Configuration

Ensure you are in the `oauth-devtools/app` directory and then create / edit the `.env` file. Ensure that your OAuth redirect URI matches the one specified in your app configuration page.

```sh
$ cd app
$ cp sample.env.txt .env
$ vim .env
```

## Usage

Ensure you are in the `oauth-devtools/app` directory and then run `app.rb`.

```sh
$ cd oauth-devtools/app
$ ruby app.rb
``` 

Then navigate your browser to the URL presented, e.g. `http://localhost:4567`.

## Links

Dropbox Ruby tutorial

* https://www.dropbox.com/developers-v1/core/start/ruby

## Contributing

1. Fork it ( http://github.com/grokify/oauth-devtools/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

OAuth DevTools is available under an MIT-style license. See [LICENSE.txt](LICENSE.txt) for details.

OAuth DevTools &copy; 2015-2016 by John Wang
