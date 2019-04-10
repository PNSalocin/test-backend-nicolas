# frozen_string_literal: true

# Representation of blood sugar level for a person at a certain time
class Glycemia < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :measurement, presence: true, numericality: { only_integer: true }
  validates :taken_at, presence: true
end
