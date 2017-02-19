[![Code Climate](https://codeclimate.com/github/HarlemSquirrel/url-checker/badges/gpa.svg)](https://codeclimate.com/github/HarlemSquirrel/url-checker)

# URL Checker

A Ruby CLI for checking a list of URLs in a CSV file

## Getting started

```sh
$ bundle install
$ bin/checkurls test.csv
404 Not Found http://google.com/cheese
301 Moved Permanently http://google.com
200 OK https://www.google.com
 3 URLs checked with 1 issue(s).
 Results saved to spec/fixtures/test_results_2017-02-19-11:44:27.csv
```
