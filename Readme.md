# Pelican

Pelican stores the final state of modified objects. You can request a list of objects which were modified when compared to the last time you saw them, which provides a fast way of syncing states of objects across systems. When objects are modified multiple times, the history of those modifications are lost and only the final state is preserved. Pelican is ideal when only the final state of an object is important, so the history of modifications can be overwritten, which minimises disk space consumption and improves sync speed.

Curently Pelican stores objects using Redis. This is a quick lightweight database, which is easily scalable to millions of objects.

## Installation

  You will need to have Redis installed. You can find this from http://redis.io/download
  
  Then it is easy to install Pelican.

    gem install pelican

  You will need to configure Redis for Pelican

    Pelican.setup(indexing_key, redis_config)

  Pelican uses any standard Redis config, so you can set up Redis in your usual way.

  e.g.

    Pelican.setup(
      'pelican:state',
      host: 'localhost',
      port: 6379,
      db: 1)

  Then just require Pelican when you need it

    require 'pelican'

  The order in which objects are stored is determined by a score. When an object is added or updated, it is given a score. The order of most modified objects is preserved by incrementing the score for each new modified score.

## Insert Objects

  To insert or update an object with its current state, just use

    Pelican::Event.insert('object1', 'state1')

## Listing objects

  You can list all the modified objects from the last known score

    current_score = Pelican::Event.list(last_score) { |object|
      puts "current object: #{object}"
    }

## Run Tests

    rake test