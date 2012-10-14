class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  attr_accessible :oid, :title
end
