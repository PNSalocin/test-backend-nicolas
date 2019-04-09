# frozen_string_literal: true

require 'test_helper'
require 'json'

class UserControllerTest < ActionDispatch::IntegrationTest
  test 'GET /users should return the users list when users are found' do
    5.times do
      create(:user)
    end

    get users_url, as: :json

    assert_response :success
    json_users = JSON.parse(@response.body)
    assert_equal 5, json_users.count
    json_users.each do |json_user|
      test_json_user(json_user)
    end
  end

  test 'GET /users should return 204 when no users are found' do
    get users_url, as: :json

    assert_response :no_content
  end

  private

  def test_json_user(json_user)
    user = User.find json_user['id']
    assert_equal user.first_name, json_user['first_name']
    assert_equal user.last_name, json_user['last_name']
    assert_equal user.gender, json_user['gender']
    assert_equal user.age, json_user['age']
  end
end
