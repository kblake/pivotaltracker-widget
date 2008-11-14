require 'rubygems'
require 'httparty'
require 'cgi'

class Api
  include HTTParty
  BASE_URI= 'https://www.pivotaltracker.com/services/v1/projects/'
  STORIES_PATH = "stories"

  default_params :output => 'xml'
  format :xml
  
  def initialize(project_id, token)
    @project_id = project_id
    @token = token
  end

  def get_project_info
    self.class.get("#{BASE_URI}#{@project_id}?token=#{@token}")
  end

  def get_story(story_id)
    get_resource(story_id)
  end

  def get_stories(filter={})
    escaped_filter= format_and_escape_filters(filter) unless filter.empty?
    get_resource(nil, escaped_filter)
  end

  def get_resource(story_id="", filter="")
    self.class.get("#{BASE_URI}#{@project_id}/stories/#{story_id}?token=#{@token}&filter=#{filter}" )
  end

  private

  def format_and_escape_filters(filters={})
    formatted_filters= ""
    filters.each do |key, value|
      formatted_filters << "#{key}:#{CGI.escape("\"#{value}\"")}%20"
    end
    formatted_filters
  end
end

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
