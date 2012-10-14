class PagesController < ApplicationController
  respond_to :html, :json
  def index
    @pages = Page.all
  end

  def show
    @page = Page.where(:url_path => params[:url_path]).first
    @url_path_components = params[:url_path].split('/')
  end

  def create
    page_params = { :url_path => params[:url_path] }
    page_params.merge!(params[:page])

    @page = Page.create(page_params)
    @page.save
  end
end
