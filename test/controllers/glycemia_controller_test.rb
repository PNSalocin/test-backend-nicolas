# frozen_string_literal: true

require 'test_helper'

class GlycemiaControllerTest < ActionDispatch::IntegrationTest
  # index
  test 'GET glycemia_index should return all glycemia data when available' do
    28.times do
      create(:glycemia)
    end

    test_multiples(glycemia_index_url, 28)
  end

  test 'GET glycemia_index should return :no_content status code when no glycemia data is found' do
    get glycemia_index_url, as: :json

    assert_response :no_content
  end

  test 'GET user_glycemia_index should return all glycemia data for correct user when available' do
    user1 = create(:user)
    user2 = create(:user)
    9.times do
      create(:glycemia, user: user1)
    end
    14.times do
      create(:glycemia, user: user2)
    end

    test_multiples(user_glycemia_index_url(user1.id), 9)
    test_multiples(user_glycemia_index_url(user2.id), 14)
  end

  test 'GET user_glycemia_index should return :no_content status code for correct user when no data is found' do
    user = create(:user)

    get user_glycemia_index_url(user.id), as: :json

    assert_response :no_content
  end

  test 'GET user_glycemia_index should raises ActiveRecord::RecordNotFound when no user is found' do
    assert_raises(ActiveRecord::RecordNotFound) do
      get user_glycemia_index_url(1), as: :json
    end
  end

  # show
  test 'GET user_glycemia should return currect glycemia data for user when available' do
    user1 = create(:user)
    user2 = create(:user)
    user1_glycemia1 = create(:glycemia, user: user1)
    create(:glycemia, user: user1)
    3.times do
      create(:glycemia, user: user2)
    end

    test_one(user_glycemia_url(user1.id, user1_glycemia1.id))
  end

  test 'GET user_glycemia should raises ActiveRecord::RecordNotFound when no user is found' do
    assert_raises(ActiveRecord::RecordNotFound) do
      get user_glycemia_url(1, 1), as: :json
    end
  end

  test 'GET user_glycemia should raises ActiveRecord::RecordNotFound when no glycemia is found for user' do
    user = create(:user)

    assert_raises(ActiveRecord::RecordNotFound) do
      get user_glycemia_url(user.id, 1), as: :json
    end
  end

  # create
  test 'POST user_glycemia with valid request should create glycemia data for user' do
    user = create(:user)
    glycemia = Glycemia.new
    glycemia.measurement = 1234
    glycemia.taken_at = Time.now

    assert_difference('Glycemia.count') do
      post user_glycemia_index_url(user.id), params: { glycemia: glycemia }, as: :json
    end

    assert_response :created
    test_json_glycemia(JSON.parse(@response.body))
  end

  test 'POST user_glycemia with invalid request should return :unprocessable_entity status code' do
    user = create(:user)

    post user_glycemia_index_url(user.id), params: { glycemia: Glycemia.new }, as: :json
    assert_response :unprocessable_entity
  end

  test 'POST user_glycemia with invalid user should raises ActiveRecord::RecordNotFound' do
    assert_raises(ActiveRecord::RecordNotFound) do
      post user_glycemia_index_url(1), params: { glycemia: Glycemia.new }, as: :json
    end
  end

  # update
  test 'PUT/PATCH user_glycemia with valid request should update glycemia data for user' do
    user = create(:user)
    glycemia = create(:glycemia, user: user, measurement: 1400, taken_at: Time.now - 1.hours)
    date = Time.now
    glycemia.measurement = 1200
    glycemia.taken_at = date

    patch user_glycemia_url(user.id, glycemia.id), params: { glycemia: glycemia }, as: :json

    assert_response :success
    test_json_glycemia(JSON.parse(@response.body))
  end

  test 'PUT/PATCH user_glycemia with invalid request should return :unprocessable_entity status code' do
    user = create(:user)
    glycemia = create(:glycemia, user: user, measurement: 1400, taken_at: Time.now - 1.hours)
    glycemia.measurement = nil

    patch user_glycemia_url(user.id, glycemia.id), params: { glycemia: glycemia }, as: :json
    assert_response :unprocessable_entity
  end

  test 'PUT/PATCH user_glycemia with invalid user should raises ActiveRecord::RecordNotFound' do
    assert_raises(ActiveRecord::RecordNotFound) do
      patch user_glycemia_url(1, 1), params: { glycemia: Glycemia.new }, as: :json
    end
  end

  test 'PUT/PATCH user_glycemia with valid user and invalid glycemia id should raise ActiveRecord::RecordNotFound' do
    user = create(:user)

    assert_raises(ActiveRecord::RecordNotFound) do
      patch user_glycemia_url(user.id, 1), as: :json
    end
  end

  # delete
  test 'DELETE user_glycemia with valid request should delete glycemia data for user' do
    user = create(:user)
    glycemia = create(:glycemia, user: user)

    assert_difference('Glycemia.count', -1) do
      delete user_glycemia_url(user.id, glycemia.id), as: :json
    end

    assert_response :no_content
  end

  test 'DELETE user_glycemia with invalid user should raises ActiveRecord::RecordNotFound' do
    assert_raises(ActiveRecord::RecordNotFound) do
      delete user_glycemia_url(1, 1), params: { glycemia: Glycemia.new }, as: :json
    end
  end

  test 'DELETE user_glycemia with valid user and invalid glycemia id should raise ActiveRecord::RecordNotFound' do
    user = create(:user)

    assert_raises(ActiveRecord::RecordNotFound) do
      delete user_glycemia_url(user.id, 1), as: :json
    end
  end

  private

  def test_multiples(route, count)
    json_glycemia_array = get_json(route)
    assert_equal count, json_glycemia_array.count
    json_glycemia_array.each do |json_glycemia|
      test_json_glycemia(json_glycemia)
    end
  end

  def test_one(route)
    json_glycemia = get_json(route)
    test_json_glycemia(json_glycemia)
  end

  def get_json(route)
    get route, as: :json

    assert_response :success
    JSON.parse(@response.body)
  end

  def test_json_glycemia(json_glycemia)
    glycemia = Glycemia.find json_glycemia['id']
    assert_equal glycemia.measurement, json_glycemia['measurement']
    assert_equal glycemia.taken_at, json_glycemia['taken_at']
  end
end
