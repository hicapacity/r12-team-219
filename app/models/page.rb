class Page < ActiveRecord::Base
  has_many :commits
  accepts_nested_attributes_for :commits
  attr_accessible :url_path, :timestamps, :commits_attributes
end
