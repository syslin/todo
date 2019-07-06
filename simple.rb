#!/usr/bin/ruby
require_relative 'mysql2'
require_relative 'rubygems'
begin
con=Mysql.new 'localhost', 'sanima1','San(*$(269833'
con.query("create table todo(id int primarykey,task varchar(255))")

rescue Mysql::Error =>Error
puts e.errno

ensure 
con.close if con
end
