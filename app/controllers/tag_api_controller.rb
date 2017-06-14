class TagApiController < ApplicationController
  protect_from_forgery except: [:add, :remove]
  def index
    @tags = Tag.where(read_status_id: params[:read_status_id])
    render json: @tags
  end

  def add
    begin
      tag = Tag.create!(read_status_id: params[:read_status_id], name:params[:tag_name])
    rescue
      render json: {message: "error"}, status: 400
      return
    end
    render json: tag

  end

  def remove
    tag = Tag.find_by(read_status_id: params[:read_status_id], name: params[:tag_name])
    begin
      tag.destroy!
    rescue
      render json: {message: "error"}, status: 400
      return
    end
    render json: {message: "success"}
  end

end
