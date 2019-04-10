# frozen_string_literal: true

# Base Application controller for project
class ApplicationController < ActionController::API
  # Returns HTTP 404 NOT FOUND status code when the requested resource coudn't be obtained
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def not_found
    head :not_found
  end
end
