class PagesController < ApplicationController
  def show
    page = Page.new ||= Page.where(:path => params[:path]).first
    render :text => page.title
  end
end
