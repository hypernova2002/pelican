require_relative File.join('..', 'test_helper')

class TestEvent < Test::Unit::TestCase

  def setup
    @objects = {'test_1' => 'state_1','test_2' => 'state_2','test_3' => 'state_3'}
    clean_up!
    
    at_exit do
      unless @clean_up
        clean_up!
      end
    end
  end

  def test_insert
    @objects.each do |(key, state)|
      Pelican::Event.insert(key, state)
    end

    @objects.each_with_index do |(key, state), index|
      assert_equal index + 1, Pelican.redis.zscore(Pelican.key, Pelican::Event.pelican_id(key))
      assert_equal state, Pelican.redis.get(Pelican::Event.pelican_id(key))
    end
  end
    
  def clean_up!
    @objects.each do |(key, state)|
      Pelican.redis.del(Pelican::Event.pelican_id(key))
      Pelican.redis.del(Pelican.key)
    end
  end
  
  def teardown
    clean_up!
    @clean_up = true
  end

end