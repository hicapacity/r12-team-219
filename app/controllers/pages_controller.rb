# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"page":{"title":"testpage","author":"nobody","markdown":"# Hallo — editing Markdown in WYSIWYG"}} ' http://slickage-x-hicap.r12.railsrumble.com/pages/hallojs
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"page":{"title":"testpage","author":"nobody","markdown":"[Hallo](/hallo/) is the simplest web editor imaginable. Instead of cluttered forms or toolbars, you edit your web content as it is. Just you, your web design, and your content."}} ' http://slickage-x-hicap.r12.railsrumble.com/pages/hallojs/foo
# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"page":{"title":"testpage","author":"nobody","markdown":"**Note:** you can also edit the Markdown source below"}} ' http://slickage-x-hicap.r12.railsrumble.com/pages/hallojs/bar

class PagesController < ApplicationController
  respond_to :html, :json
  def index
    pages = Page.all
    render :text => pages.to_json 
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
