OAuth DevTools
==============

This app provides a set of OAuth development tools.

It provides an easy way to retrieve access tokens from cloud services (e.g. Dropbox) and stores them on the file system in a `.env` file that can be read easily by apps in any language. This removes the need of manually copy and pasting access tokens into apps for development purposes and also provides some implementation code examples for redirection. This app provides an OAuth redirect URI which is necessary to configure in your app.

### Benefits

1. Eliminates need to copy and paste access token in development by storing the access token in a program accessible file system location
1. Provides example code for production OAuth with redirection when [some SDK tutorials](https://www.dropbox.com/developers-v1/core/start/ruby) do not

### Support

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
