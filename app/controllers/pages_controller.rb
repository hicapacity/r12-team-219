class PagesController < ApplicationController
  respond_to :html, :json
  def index
    pages = Page.all
    render :text => pages.count
  end

  def show
    @page = Page.where(:url_path => params[:url_path]).first
  end

  def create
    @page = Page.create(params[:page])
    # @page.url_path = params[:url_path]
    @page.save
  end
end
