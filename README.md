Setting up your wikifiles repository
====================================

In order for this project to work, you need to create a git repository to store
the wiki pages. Assuming you are in the project's directory (r12-team-219), run
these commands:

```
cd ..
mkdir wikifiles
cd wikifiles
git init --bare
cd ..
git clone -l wikifiles wikifiles2
cd wikifiles2
git commit --allow-empty
git push origin master
```

At this point, you can delete the wikifiles2 directory if you'd like.

If you'd like to create some test pages, start up a "rails console" and run:

```ruby
p = Page.new
p.url_path = "test"
p.title = "Test Page"
p.markdown = "This is a test page."
p.author = User.first
p.save
```

You should now be able to load /pages/test.