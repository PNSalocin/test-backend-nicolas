# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    create(:glycemia, user: @user, measurement: 1176, taken_at: Time.now - 6.days - 9.hours)
    create(:glycemia, user: @user, measurement: 1415, taken_at: Time.now - 4.days - 21.hours)
    create(:glycemia, user: @user, measurement: 1014, taken_at: Time.now - 3.days - 7.hours)
    create(:glycemia, user: @user, measurement: 1284, taken_at: Time.now - 3.days - 2.hours)
    create(:glycemia, user: @user, measurement: 1732, taken_at: Time.now - 1.day - 12.hours)
  end

  test '#glycemia_count' do
    assert_equal 5, @user.glycemia_count
  end

  test '#glycemia_count_since' do
    assert_equal 0, @user.glycemia_count_since(1.day.ago)
    assert_equal 1, @user.glycemia_count_since(2.days.ago)
    assert_equal 1, @user.glycemia_count_since(3.days.ago)
    assert_equal 3, @user.glycemia_count_since(4.days.ago)
    assert_equal 4, @user.glycemia_count_since(5.days.ago)
    assert_equal 4, @user.glycemia_count_since(6.days.ago)
    assert_equal 5, @user.glycemia_count_since(7.days.ago)
  end

  test '#glycemia_average' do
    assert_equal 1324, @user.glycemia_average
  end

  test '#glycemia_average_since' do
    assert_equal 0, @user.glycemia_average_since(1.day.ago)
    assert_equal 1732, @user.glycemia_average_since(2.days.ago)
    assert_equal 1732, @user.glycemia_average_since(3.days.ago)
    assert_equal 1343, @user.glycemia_average_since(4.days.ago)
    assert_equal 1361, @user.glycemia_average_since(5.days.ago)
    assert_equal 1361, @user.glycemia_average_since(6.days.ago)
    assert_equal 1324, @user.glycemia_average_since(7.days.ago)
  end
end
