# frozen_string_literal: true

# Representation of a person in the project
class User < ApplicationRecord
  enum gender: %i[unknown_gender male female other_gender]
end
