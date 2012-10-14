class Page < ActiveRecord::Base
  after_initialize :setup_repo_variables
  before_save :save_to_repo
  before_destroy :erase_from_repo
  
  has_many :commits
  accepts_nested_attributes_for :commits
  attr_accessible :url_path, :timestamps, :commits_attributes
  
  def title
    unless @title_loaded
      get_latest_version unless @latest_commit
      @title = @latest_commit.title
      @title_loaded = true
      @title_dirty = false
    end
    @title
  end
  
  def title=(title)
    @title = title
    @title_loaded = true
    @title_dirty = true
    self
  end
  
  def markdown
    unless @markdown_loaded
      get_latest_version unless @latest_commit
      @markdown = @latest_commit.markdown
      @markdown_loaded = true
      @markdown_dirty = false
    end
    @markdown
  end

  def markdown=(markdown)
    @markdown = markdown
    @markdown_loaded = true
    @markdown_dirty = true
    self
  end
  
  def author
    unless @author_loaded
      get_latest_version unless @latest_commit
      @author = @latest_commit.user
      @author_loaded = true
    end
    @author
  end
  
  def author=(user)
    @author = user
    @author_loaded = true
  end
  
  protected
  
  def setup_repo_variables
    @title_loaded = false
    @title_dirty = false
    @markdown_loaded = false
    @markdown_dirty = false
    @author_loaded = false
    @latest_commit = nil
  end

  def get_latest_version
    @latest_commit = self.commits.first
  end
  
  def save_to_repo
    if @markdown_dirty
      commits << Commit.create_commit(self)
      @markdown_dirty = false
    end
    true
  end
  
  def erase_from_repo
    repo = Rugged::Repository.new(Rails.root.join('..', 'wikifiles').to_s)

    # find the appropriate tree for our blob
    master_ref = Rugged::Reference.lookup repo, 'refs/heads/master'
    tree = repo.lookup(master_ref.target).tree
    path = Pathname.new(url_path).each_filename.to_a
    filename = path.pop
    path.each do |part|
      tree = tree.find {|entry| entry[:name] == part}
    end
    
    # add blob to tree
    tree = Rugged::Tree::Builder.new tree
    tree.remove filename
    tree_id = tree.write repo

    author_name = "#{author.first_name} #{author.last_name}".strip
    author_name = author.email if author_name.blank?
    auth = {:email => author.email, :name => author_name, :time => Time.now}
    Rugged::Commit.create repo,
      :author => auth,
      :message => "Deleted #{url_path}",
      :committer => auth,
      :parents => [repo.head.target],
      :update_ref => 'HEAD',
      :tree => tree_id
    true
  end
end
