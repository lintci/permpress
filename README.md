# Permpress
[![Codeship Status for lintci/permpress](https://www.codeship.io/projects/f6b29410-0a8f-0132-55ca-3e7f86a10108/status)](https://www.codeship.io/projects/31800)

A CLI to wrap the inconsistencies of various linters.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'permpress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install permpress

## Usage

The following request that you have all dependencies installed

``` bash
permpress checkstyle lint (--config=CONFIGURATION_FILE) [FILES]
permpress coffeelint lint (--config=CONFIGURATION_FILE) [FILES]
permpress csslint lint [FILES]
permpress golint lint (--config=CONFIGURATION_FILE) [FILES]
permpress jshint lint (--config=CONFIGURATION_FILE) [FILES]
permpress jsonlint lint (--config=CONFIGURATION_FILE) [FILES]
permpress rubocop lint (--config=CONFIGURATION_FILE) [FILES]
permpress scsslint lint (--config=CONFIGURATION_FILE) [FILES]
```

### Dependencies

* node/npm
  * coffeelint
  * csslint
  * durable-json-lint-cli
  * jshint
* java
* go
  * golint
* ruby
  * rubocop
  * scsslint

## Contributing

1. Fork it ( https://github.com/[my-github-username]/permpress/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
