class Page < ActiveRecord::Base
  has_many :commits
  accepts_nested_attributes_for :commits
  attr_accessible :url_path, :timestamps, :commits_attributes
  
  def title
    get_latest_version unless @latest_commit
    @latest_commit.title
  end
  
  def markdown
    get_latest_version unless @latest_commit
    @latest_commit.markdown
  end
  
  protected

  def get_latest_version
    @latest_commit = self.commits.ordered_by_date.first
  end
end
