class Page < ActiveRecord::Base
  has_many :commits
  attr_accessible :url_path, :timestamps 
end
