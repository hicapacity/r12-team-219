class Commit < ActiveRecord::Base
  after_initialize :setup_repo_variables
  before_save :save_to_repo
  
  belongs_to :user
  belongs_to :page
  attr_accessible :oid, :title
  scope :ordered_by_date, order('updated_at desc')
  
  def self.create_commit(page)
    commit = Commit.new(:title => page.title)
    commit.__send__(:markdown=, page.markdown)
    commit.page = page
    commit.user = page.author
    commit
  end

  def markdown
    unless @markdown_loaded
      repo = Rugged::Repository.new(Rails.root.join('..', 'wikifiles').to_s)
      commit = repo.lookup oid
      blob = commit.tree
      path = Pathname.new(page.url_path + '.md')
      path.each_filename do |part|
        blob = blob.find {|entry| entry[:name] == part}
      end
      @markdown = repo.lookup(blob[:oid]).content
      @markdown_loaded = true
    end
    @markdown
  end
  
  protected
  
  def markdown=(markdown)
    @markdown = markdown
    @markdown_loaded = true
    @repo_dirty = true
  end
  
  def setup_repo_variables
    @markdown_loaded = false
    @repo_dirty = false
  end
  
  def save_to_repo
    if @repo_dirty
      repo = Rugged::Repository.new(Rails.root.join('..', 'wikifiles').to_s)
      blob_oid = Rugged::Blob.create repo, markdown

      # find the appropriate tree for our blob
      master_ref = Rugged::Reference.lookup repo, 'refs/heads/master'
      tree = repo.lookup(master_ref.target).tree
      path = Pathname.new(page.url_path).each_filename.to_a
      filename = path.pop + '.md'
      trees = []
      path.each do |part|
        trees.unshift([part, tree])
        unless tree.nil?
          tree_entry = tree.find {|entry| entry[:name] == part}
          tree = tree_entry.nil?() ? nil : repo.lookup(tree_entry[:oid])
        end
      end
      
      # add blob to tree, and modify parent trees
      builder = tree.nil?() ? Rugged::Tree::Builder.new() : Rugged::Tree::Builder.new(tree)
      builder << {:type => :blob, :name => filename, :oid => blob_oid, :filemode => 33188}
      tree_id = builder.write repo
      trees.each do |parttree|
        part, tree = parttree
        builder = tree.nil?() ? Rugged::Tree::Builder.new() : Rugged::Tree::Builder.new(tree)
        builder << {:type => :tree, :name => part, :oid => tree_id, :filemode => 16384}
        tree_id = builder.write repo
      end

      author = "#{user.first_name} #{user.last_name}".strip
      author = user.email if author.blank?
      auth = {:email => user.email, :name => author, :time => Time.now}
      self.oid = Rugged::Commit.create repo,
        :author => auth,
        :message => "Committed #{page.url_path}",
        :committer => auth,
        :parents => [repo.head.target],
        :update_ref => 'HEAD',
        :tree => tree_id
      @repo_dirty = false
    end
    true
  end
end
