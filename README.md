[![Code Climate](https://codeclimate.com/github/GeekPark/geekpark/badges/gpa.svg)](https://codeclimate.com/github/GeekPark/geekpark)
[![Test Coverage](https://codeclimate.com/github/GeekPark/geekpark/badges/coverage.svg)](https://codeclimate.com/github/GeekPark/geekpark/coverage)
[![Travis-CI](https://travis-ci.org/GeekPark/geekpark.svg)](https://travis-ci.org/GeekPark/geekpark)

This is the source code of Geekpark website.

## Requirements

- Ruby 2.3.1+
- PostgreSQL 9+


## Setting up Development Environment

Install required gems:

```bash
$ bundle
```

Create database and load the database schema:

```bash
$ rake db:create
$ rake db:schema:load
```
