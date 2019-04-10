# frozen_string_literal: true

class UsersController < ApplicationController #:nodoc:
  has_scope :by_gender, only: :index
  has_scope :by_age, only: :index
  has_scope :by_age_range, using: %i[minimum maximum], only: :index

  # GET /users
  # GET /users?by_gender={gender}
  # GET /users?by_age={age}
  # GET /users?by_age_range[minimum]={minimum}&by_age_range[maximum]=maximum
  def index
    users = apply_scopes(User).all
    return head(:no_content) if users.blank?

    render json: users, methods: [:glycemia_count, :glycemia_average]
  end
end
