require 'json'
require 'net/http'

class Feedback
  def initialize(feedback_type, user_id, item_id, timestamp)
    @feedback_type = feedback_type
    @user_id = user_id
    @item_id = item_id
    @timestamp = timestamp
  end

  def to_json(options = {})
    {
      'FeedbackType' => @feedback_type,
      'UserId' => @user_id,
      'ItemId' => @item_id,
      'Timestamp' => @timestamp
    }.to_json(options)
  end
end

class RowAffected
  def initialize(row_affected)
    @row_affected = row_affected
  end

  def self.from_json(string)
    data = JSON.load string
    self.new data['RowAffected']
  end

  attr_reader :row_affected
end

class Gorse
  def initialize(endpoint, api_key = "")
    @endpoint = endpoint
    @api_key = api_key
  end

  def insert_feedback(feedback)
    uri = URI("#{@endpoint}/api/feedback")
    response = Net::HTTP::post(uri, JSON.generate(feedback), {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    })
    RowAffected.from_json(response.body)
  end

  def get_recommend(user_id)
    uri = URI("#{@endpoint}/api/recommend/#{user_id}")
    response = Net::HTTP::get(uri)
    JSON.parse(response)
  end
end
