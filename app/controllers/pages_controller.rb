# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"page":{"title":"testpage","author":"nobody","markdown":"asdf"}} ' http://0.0.0.0:3000/pages/foo/bar

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
    page_params = { :url_path => params[:url_path] }
    page_params.merge!(params[:page])

    @page = Page.create(page_params)
    @page.save
  end
end
