# gorse-rb

[![Ruby](https://github.com/gorse-io/gorse-rb/actions/workflows/ci.yml/badge.svg)](https://github.com/gorse-io/gorse-rb/actions/workflows/ci.yml)
[![Gem](https://img.shields.io/gem/v/gorse)](https://rubygems.org/gems/gorse)
[![Gem](https://img.shields.io/gem/dt/gorse)](https://rubygems.org/gems/gorse)

Ruby SDK for gorse recommender system

## Install

```bash
gem install gorse
```

## Usage

```ruby
require 'gorse'

client = Gorse.new('http://127.0.0.1:8087', 'api_key')

client.insert_feedback([
    Feedback.new("read", "10", "3", "2022-11-20T13:55:27Z"),
    Feedback.new("read", "10", "4", "2022-11-20T13:55:27Z"),
])

client.get_recommend('10')
```
