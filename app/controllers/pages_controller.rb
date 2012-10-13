class PagesController < ApplicationController
  def index
    pages = Page.all
    render :text => pages.count
  end
  def show
    @page = Page.where(:url_path => params[:url_path]).first
  end
end
