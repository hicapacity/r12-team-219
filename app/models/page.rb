class Page < ActiveRecord::Base
  attr_accessible :url_path, :title, :author, :markdown, :timestamps 
end
