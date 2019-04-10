# frozen_string_literal: true

class UsersController < ApplicationController #:nodoc:
  has_scope :by_gender, only: :index
  has_scope :by_age, only: :index
  has_scope :by_age_range, using: %i[minimum maximum], only: :index

  # GET /users
  def index
    users = apply_scopes(User).all
    return head(:no_content) if users.blank?

    render json: users
  end
end
