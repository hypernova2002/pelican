module Pelican
  module Event
    extend self

    def insert(id, state)
      begin
        Pelican.redis.multi do
          Pelican.redis.set(pelican_id(id), state)
        end
        update_event_list(pelican_id(id))
      end
    end

    def delete(id)
      begin
        Pelican.redis.multi do
          Pelican.redis.zrem(Pelican.key, pelican_id(id))
          Pelican.del(pelican_id(id))
        end
      end
    end

    def list(last_score = 0)
      max_score = last_score
      last_score = '(' + last_score.to_s # make the search on last score exclusive
      Pelican.redis.zrangebyscore(Pelican.key, last_score, '+inf', { withscores: true }).each do |id|
        yield Pelican.redis.get(id[0])
        max_score = id[1]
      end
      max_score
    end

    def pelican_id(id)
      ['pelican', id].join(':')
    end

    private

    def update_event_list(id)
      with_max_score do |max_score|
        Pelican.redis.multi do
          Pelican.redis.zadd(Pelican.key, max_score + 1, id)
        end
      end
    end

    def with_max_score
      begin
        Pelican.redis.watch(Pelican.key)
        last_object = Pelican.redis.zrange(Pelican.key, -1, -1, { withscores: true })[0]
        yield last_object.nil? ? 0 : last_object[1]
      rescue => e
        raise e
      ensure
        Pelican.redis.watch(Pelican.key)
      end
    end

  end
end