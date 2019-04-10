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
    json_users = @response.parsed_body
    assert_equal 5, json_users.count
    json_users.each do |json_user|
      test_json_user(json_user)
    end
  end

  test 'GET /users should return 204 when no users are found' do
    get users_url, as: :json

    assert_response :no_content
  end

  test 'GET /users?by_gender should return correct users' do
    create(:user, gender: User.genders[:male])
    user_f1 = create(:user, gender: User.genders[:female])
    create(:user, gender: User.genders[:other_gender])
    user_f2 = create(:user, gender: User.genders[:female])
    user_f3 = create(:user, gender: User.genders[:female])
    create(:user, gender: User.genders[:male])

    get users_url, params: { by_gender: :female }

    assert_response :success
    json_users = @response.parsed_body
    assert_equal [user_f1.id, user_f2.id, user_f3.id], json_users.pluck('id')
  end

  test 'GET /users?by_age should return correct users' do
    create(:user, age: 14)
    create(:user, age: 64)
    create(:user, age: 13)
    user_age56 = create(:user, age: 56)
    create(:user, age: 74)

    get users_url, params: { by_age: 56 }

    assert_response :success
    json_users = @response.parsed_body
    assert_equal [user_age56.id], json_users.pluck('id')
  end

  test 'GET /users?by_age_range should return correct users' do
    user_age14 = create(:user, age: 14)
    create(:user, age: 64)
    user_age13 = create(:user, age: 13)
    create(:user, age: 56)
    create(:user, age: 74)

    get users_url, params: { by_age_range: { minimum: 13, maximum: 18 } }

    assert_response :success
    json_users = @response.parsed_body
    assert_equal [user_age14.id, user_age13.id], json_users.pluck('id')
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
