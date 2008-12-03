require 'rubygems'
require 'httparty'
require 'cgi'
require 'yaml'

class Api
  include HTTParty
  BASE_URI= 'https://www.pivotaltracker.com/services/v1/projects/'
  STORIES_PATH = "stories"

  default_params :output => 'xml'
  format :xml	
  
  def initialize
		config = get_credentials
    @project_id = config['project_id']
    @token = config['token']
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

	def get_credentials
		begin
			YAML.load_file("pivotal_credentials.yml")
		rescue
			puts "\nPlease rename the pivotal_credentials.yml.template to pivotal_credentials.yml and edit the file.  You'll need your project id and token as provided by Pivotal Tracker.\n\n"
			exit
		end
	end
end
