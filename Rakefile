require 'pg'

 task :test_database_setup do
   p "Cleaning database..."

   connection = PG.connect(dbname: 'bookmark_manager_test')

   # Clear the database
   connection.exec("TRUNCATE comments, bookmarks;")

   # Add the test data
   connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com', 'Makers Academy');")
   connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.google.com', 'Google');")
   connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.facebook.com', 'Facebook');")
 end

 task :setup do
   p "Creating databases..."

   ['bookmark_manager', 'bookmark_manager_test'].each do |database|
     connection = PG.connect
     connection.exec("CREATE DATABASE #{ database };")
     connection = PG.connect(dbname: database)
     connection.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")
     connection.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks (id), text VARCHAR(240));")
   end
end

  task :teardown do
  p "Tearing down databases..."

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{ database };")
   end
 end
