class TagsController < ApplicationController
  before_action :set_member
  before_action :set_member_tag, only: [:show, :update, :destroy]

  # GET /members/:member_id/tags
  def index
    json_response(@member.tags)
  end

  # GET /members/:member_id/tags/:id
  def show
    json_response(@tag)
  end

  # POST /members/:member_id/tags
  def create
    @member.tags.create!(tag_params)
    json_response(@member, :created)
  end

  # PUT /members/:member_id/tags/:id
  def update
    @tag.update(tag_params)
    head :no_content
  end

  # DELETE /members/:member_id/tags/:id
  def destroy
    @tag.destroy
    head :no_content
  end

  private

  def tag_params
    params.permit(:name, :done)
  end

  def set_member
    @member = Member.find(params[:member_id])
  end

  def set_member_tag
    @tag = @member.tags.find_by!(id: params[:id]) if @member
  end
end