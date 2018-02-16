require 'pg'
require 'uri'
require './lib/database_connection'

class Link

  attr_reader :url, :id, :title

  def initialize(url, id, title)
    @url = url
    @id = id
    @title = title
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM links")
    result.map { |link| Link.new(link['url'], link['id'], link['title']) }

  end

  def self.add_new_link(new_link)
    raise "You must submit a valid URL." unless working_link?(new_link)
    title = new_link.sub(/^https?\:\/\/(www.)?/,'')[/[^.]+/].capitalize!
    DatabaseConnection.query("INSERT INTO links(url, title) VALUES('#{new_link}', '#{title}')")
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM links WHERE id = '#{id}'")
  end

  def self.update(id, new_link)
    raise "You must submit a valid URL." unless working_link?(new_link)
    title = new_link.sub(/^https?\:\/\/(www.)?/,'')[/[^.]+/].capitalize!
    DatabaseConnection.query("UPDATE links SET title ='#{title}' WHERE id='#{id}'")
    DatabaseConnection.query("UPDATE links SET url ='#{new_link}' WHERE id='#{id}'")
  end

  private

  def self.working_link?(new_link)
    new_link =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
  end
end
