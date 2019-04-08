# frozen_string_literal: true

# Base Application record for project
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
