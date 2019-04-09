# frozen_string_literal: true

class UsersController < ApplicationController #:nodoc:
  # GET /users
  def index
    users = User.all
    return head(:no_content) if users.blank?

    render json: users
  end
end
