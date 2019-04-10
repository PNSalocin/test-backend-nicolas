# frozen_string_literal: true

class GlycemiaController < ApplicationController #:nodoc:
  before_action :set_user, only: %i[show create update destroy]
  before_action :set_glycemia, only: %i[show update destroy]

  # GET /glycemia
  # GET /user/{user_id}/glycemia
  def index
    glycemia = params[:user_id].present? ? User.find(params[:user_id]).glycemia.all : Glycemia.all
    return head(:no_content) if glycemia.blank?

    render json: glycemia
  end

  # GET /user/{user_id}/glycemia/{glycemia_id}
  def show
    render json: @glycemia
  end

  # POST /user/{user_id}/glycemia
  def create
    glycemia = @user.glycemia.new(glycemia_params)

    if glycemia.save
      render json: glycemia, status: :created
    else
      render json: glycemia.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user/{user_id}/glycemia/{glycemia_id}
  def update
    if @glycemia.update(glycemia_params)
      render json: @glycemia
    else
      render json: @glycemia.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user/{user_id}/glycemia/{glycemia_id}
  def destroy
    @glycemia.destroy
  end

  private

  # Fetch user by id
  def set_user
    @user = User.find(params[:user_id])
  end

  # Fetch glycemia instance from user (who should have been retrieved before) by id
  def set_glycemia
    @glycemia = @user.glycemia.find(params[:id])
  end

  # Glycemia parameters validation
  def glycemia_params
    params.require(:glycemia).permit(:measurement, :taken_at)
  end
end
