[![Code Climate](https://codeclimate.com/github/HarlemSquirrel/url-checker/badges/gpa.svg)](https://codeclimate.com/github/HarlemSquirrel/url-checker)

# URL Checker

A Ruby CLI for checking a list of URLs from a CSV file. Checkout the [RubGems page](https://rubygems.org/gems/url-checker).

## Requirements

- Ruby 2.4+
- Internet connection

## Getting started

### Install and run from RubyGems

```sh
$ gem install url-checker
$ checkurls path/to/file.csv
```

### Install and run manually

Clone the repo and bundle

```sh
$ git clone https://github.com/HarlemSquirrel/url-checker.git
$ bundle install
```

Try the test file

```sh
$ bin/checkurls spec/fixtures/test.csv
 404 Not Found http://google.com/cheese
 301 Moved Permanently http://google.com
 200 OK https://www.google.com
  3 URLs checked with 1 issue(s).
  Results saved to spec/fixtures/test_results_2017-02-19-11:44:27.csv
```
