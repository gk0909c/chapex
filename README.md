# Chapex
This gem checks apex code syntax for continuous integration.

NOTE: This gem is in developing.

## Installation
clone this repository and build, install manually.

## Usage
see result of `chapex help`

## checks
chapex do below checks.  
note, chapx is not configurable with files like checkstyle and other tools.


| category | check                                    |
| ---      | ---                                      |
| naming   | class name is upper camelcase            |
| naming   | field name is lower camelcase            |
| naming   | method name is lower camelcase           |
| naming   | method arguments name is lower camelcase |
| naming   | local variable name is lower camelcase   |
| indent   | indent with 4 spaces                     |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

