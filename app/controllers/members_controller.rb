class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  # GET /members
  def index
    # get all members
    @members = Member.all
    json_response(@members)
  end

  # GET /members/:id
  def show
    json_response(@member)
  end

  # POST /members
  def create
    # create members
    @member = Member.create!(member_params)
    json_response(@member, :created)
  end

  # PUT /members/:id
  def update
    @member.update(member_params)
    head :no_content
  end

  # DELETE /members/:id
  def destroy
    @member.destroy
    head :no_content
  end

  private

  def member_params
    params.permit(:first_name, :last_name, :member_type, :role, :duration)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end