# URL Checker

A Ruby CLI for checking a list of URLs in a CSV file

## Getting started

```sh
$ bundle install
$ ruby bin/checkurls test.csv
 200 OK https://www.google.com
 301 Moved Permanently http://google.com
 404 Not Found http://google.com/cheese
  3 URLs checked with 1 issue(s).
  Results saved to test_results_2017-02-18-13:52:39.csv
```
