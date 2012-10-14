class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  attr_accessible :oid, :title, :markdown

  def markdown
    @markdown
  end

  def markdown=(val)
    @markdown = val
  end
end
