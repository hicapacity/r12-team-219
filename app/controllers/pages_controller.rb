class PagesController < ApplicationController
  respond_to :html, :json
  def index
    @pages = Page.all
  end

  def show
    @page = Page.where(:url_path => params[:url_path]).first
    @url_path = params[:url_path]
    @url_path_components = params[:url_path].split('/')
    puts params

    respond_with @page
  end

  def post
    # page_params = { :url_path => params[:url_path] }
    # page_params.merge!(params[:page])

    if user_signed_in?
      @page = Page.where(:url_path => params[:url_path]).first
      if @page.nil?
        @page = Page.new
        @page.title = params[:url_path]
        @page.url_path = params[:url_path]
      end
      
      @page.author = current_user
      @page.markdown = params[:markdown];
      @page.save
    end

    respond_with @page, :location => "/pages/#{@page.url_path}"
    # @page = Page.create(page_params)
    # @page.save
  end
end
