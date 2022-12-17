require_relative '../lib/gorse'

require 'redis'
require "test/unit"

class TestGorse < Test::Unit::TestCase

  def setup
    @client = Gorse.new('http://127.0.0.1:8088')
    @redis = Redis.new(:host => '127.0.0.1')
  end

  def test_feedback
    feedback = [
      Feedback.new("read", "10", "3", "2022-11-20T13:55:27Z"),
      Feedback.new("read", "10", "4", "2022-11-20T13:55:27Z"),
    ]
    row_affected = @client.insert_feedback(feedback)
    assert_equal(2, row_affected.row_affected)
  end

  def test_recommend
    @redis.zadd('offline_recommend/10', [[1, '10'], [2, '20'], [3, '30']])
    items = @client.get_recommend('10')
    assert_equal(%w[30 20 10], items)
  end

end