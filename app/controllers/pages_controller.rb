class PagesController < ApplicationController
  def show
    page = Page.new ||= Page.where(:url_path => params[:url_path]).first
    render :text => page.title
  end
end
