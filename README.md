[![Build Status](https://travis-ci.org/coderly/filterable.png)](https://travis-ci.org/coderly/filterable)
[![Code Climate](https://codeclimate.com/github/coderly/filterable.png)](https://codeclimate.com/github/coderly/filterable)

## Overview

Filterable is a micro gem that allows you to build filterable collections in a modular fashion. You can encapsulate filtering logic inside filter objects and attach them to collections.

## Benefits
#### Reuse filtering logic between projects
For example, if you have a `TimeOfDay` filter, a geospatial `Location` filter, or an elastic search `FullText` filter, you can hide the horrific implementation inside a filter object.

#### Keep filtering logic out of your models
Keeps your models from growing out of control and taking on too much responsibility
[Rule #4 Extract Query Objects](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

#### Simpler to expose an API
Instead of chaining a bunch of scopes for your API response, you can instantiate a Filterable collection, pass in the get params, and present it back.

## Installation

Add this line to your application's Gemfile:

    gem 'filterable', github: 'coderly/filterable'

And then execute:

    $ bundle


## Basic Example

Imagine you have an ActiveRecord model called User with an id, username, tags, and timestamps.

```ruby
class User
    acts_as_taggable
end
```

You could create a user collection and make use of these filters like so:
```ruby
class UserCollection < Filterable::Collection
    filter :registered_after, CreatedAfterFilter
    filter :category, TagFilter
end
```

You could define the filters as so
```ruby
 class TimeFilter
  def initialize(time)
    @time = time
  end

  def call(collection)
    if @time
        condition = collection.arel_table[:created_at].gt(@time)
        collection.where(condition)
    else
        collection
    end
  end
end

class TagFilter
  def initialize(category)
    @category = category
  end

  def call(collection)
    if @category
        collection.tagged_with @category
    else
        collection
    end
  end
end
```

When you then call
```ruby
UserCollection.new(User.all, created_after: yesterday, category: 'moderator')
```
You get a collection of filtered users.


  [1]: http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/
