require 'pg'

task :setup do
  p "Creating databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{ database };")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE links(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")
  end
end

task :test_database_setup do
  p "Cleaning database"

  if ENV['ENVIRONMENT'] == 'test'

    DatabaseConnection.setup("bookmark_manager_test")
    DatabaseConnection.query("TRUNCATE links")
    DatabaseConnection.query("INSERT INTO links VALUES(1, 'http://www.makersacademy.com', 'Makers Academy')")
    DatabaseConnection.query("INSERT INTO links VALUES(2, 'http://www.google.com', 'Google')")
    DatabaseConnection.query("INSERT INTO links VALUES(3, 'http://www.facebook.com', 'Facebook')")
  end
end
