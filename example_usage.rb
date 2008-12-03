require 'api'

a = Api.new(3655, "5dfe63f99361824f34e3d79356275c2f")
p a.get_project_info
p a.get_story(277352)
p a.get_stories
p a.get_stories(:type=>"bug")
# Api.add_story(:story=>{:name=>"", :description=>""})
# Api.update_story(:story=>{})
# Api.delete_story(277352)


#is factory overkill?  maybe? maybe not?
# project = Factory.project #Project.new
# project.name
# 
# story = Factory.story(355)  #returns a Story.new
# puts story.url
# puts story.name
# story.update_attributes(:name=>"some cool new name")
# story.destroy
