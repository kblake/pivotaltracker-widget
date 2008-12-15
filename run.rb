require File.join(File.dirname(__FILE__), "lib", "api")
require "rubygems"
require "highline/import"
HighLine.track_eof = false

a = Api.new

loop do

	puts "Welcome to the Pivotal Tracker console application"
	choose do |menu|
		menu.prompt = "What do you want to do?"
  	menu.choice(:project_info) { p a.get_project_info }
		menu.choice(:stories) { p a.get_stories }
  	menu.choice(:story) { 
			story = ask("Enter story number:  ", Integer)
			p a.get_story(story)
 		}
		menu.choice(:bugs){ p a.get_stories(:type=>"bug") }
		menu.choice(:quit, "Exit program.") { exit }
	end

end
