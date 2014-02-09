module Pelican
  extend self
  attr_accessor :redis, :key
  
  def setup(key = nil, opts = {})
    @key = key || default_key
    @redis = Redis.new(opts)
  end

  def default_key
    'pelican:state'
  end

end
