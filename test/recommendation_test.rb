require 'minitest/autorun'
require_relative '../recommendation'
class TestRecommendation < MiniTest::Test
  def setup
    @users = {}
    file = CSV.read('test/sample.txt')
    file.shift
    file.each do |line|
      data = line[0].split(';')
      @users[data[0].to_i] ||= User.new(id: data[0].to_i)
      @users[data[0].to_i].products << data[1].to_i
    end
    @users.each do |_id, user|
      user.set_signature!
    end
    @engine = Recommendation::Engine.new(@users.values)
  end

  def test_user1
    assert (@engine.recommendation_for(@users[1]).include? 42)
  end

  def test_user2
    assert (@engine.recommendation_for(@users[2]).include? 47)
  end

  def test_user3
    assert_equal @engine.recommendation_for(@users[3]), []
  end

  def test_user4
    assert (@engine.recommendation_for(@users[4]).any? { |i| [32, 45].include? i })
  end

  def test_user5
    assert_equal @engine.recommendation_for(@users[5]), []
  end
end
