# frozen_string_literal: true

# Representation of a person in the project
class User < ApplicationRecord
  has_many :glycemia

  scope :by_gender, ->(gender) { where(gender: gender) }
  scope :by_age, ->(age) { where(age: age) }
  scope :by_age_minimum, ->(minimum) { where('age >= ?', minimum) }
  scope :by_age_maximum, ->(maximum) { where('age <= ?', maximum) }
  scope :by_age_range, ->(minimum, maximum) { by_age_minimum(minimum).by_age_maximum(maximum) }

  enum gender: %i[unknown_gender male female other_gender]

  # Returns the count of glycemia entries for user
  #
  # @return [int] count
  def glycemia_count
    glycemia.count(:measurement)
  end

  # Returns the count of glycemia entries for user since given date
  #
  # @param [DateTime] taken_at
  # @return [int] count
  def glycemia_count_since(taken_at)
    glycemia.where('taken_at >= ?', taken_at).count(:measurement)
  end

  # Returns the average of glycemia entries for user
  #
  # @param [DateTime] taken_at
  # @return [int] average value
  def glycemia_average
    glycemia.average(:measurement).to_i
  end

  # Returns the average of glycemia entries for user since given date
  #
  # @param [DateTime] taken_at
  # @return [int] average value
  def glycemia_average_since(taken_at)
    glycemia.where('taken_at >= ?', taken_at).average(:measurement).to_i
  end
end
