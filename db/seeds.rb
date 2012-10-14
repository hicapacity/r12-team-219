# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(:email => "test@gmail.com", :password => "1234567")
p = Page.new
p.url_path = "test"
p.title = "Test Page"
p.markdown = "This is a test page."
p.author = user1
p.save

p.title = "changed title"
p.markdown = "changed markdown"
p.save

user2 = User.create(:email => "test1@gmail.com", :password => "1234567")
p = Page.new
p.url_path = "test2"
p.title = "Test2 Page"
p.markdown = "This is test2 page."
p.author = user1
p.save

p.title = "changed title 2"
p.markdown = "changed markdown 2"
p.author = user2
p.save

p = Page.new
p.url_path = 'test/nested'
p.title = 'Nested Page'
p.markdown = 'This is a nested page!'
p.author = user1
p.save