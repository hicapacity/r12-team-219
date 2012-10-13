class Page < ActiveRecord::Base
  attr_accessible :author, :markdown, :timestamps, :title
end
