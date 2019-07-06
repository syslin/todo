require "mysql2"
require "pry"

class Database
  def connectdb
    @c = Mysql2::Client.new(:host => "localhost", :username => "sanima1", :password => "San(*$(269833", :database => "todo_application")
    return @c
  end

  def create_table
    sql = @c.query("create table todo_table(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,task_title varchar(100),task_todo varchar(255),notes text,Date datetime,Date_complete datetime,status int(2))")
  end

  def insert(task_title, task_todo, notes, date_complete, status = 0)
    sql = @c.query("insert into todo_table (task_title,task_todo,notes,date,Date_to_complete,status) values ('#{task_title}','#{task_todo}','#{notes}',now(),'#{date_complete}','#{status}')")
    return @c.affected_rows
  end

  # def display
  #   sql = @c.query("Select id, task_title,task_todo from todo_table")
  #   if sql.count != 0
  #     puts "id\ttask_title\ttask_todo\t "
  #     sql.each do |k|
  #       puts "#{k["id"]}\t#{k["task_title"]}\t \t#{k["task_todo"]}\t"
  #     end
  #   else
  #     puts "\nNO Task FOUND\n"
  #   end
  # end

  def edit(id, columns = {})
    #binding.pry
    sql = @c.query("Select id from todo_table")
    sql.each { |table_id|
      if ("#{table_id["id"]}" == "#{id}")
        str = []
        columns.each { |k, v| str << "#{k} = \'#{v}\'" }
        str = str.join("")
        @c.query("update todo_table set #{str} where id=#{id}")
        puts "TASK UPDATED SUCCESSFULLY"
        puts "_________________________"
        display(sql)
      else
        puts "Please check the id"
      end
    }
  end

  def delete_data(id)
    sql = @c.query("Select id from todo_table")
    sql.each { |table_id|
      if ("#{table_id["id"]}" == "#{id}")
        @c.query("Delete from todo_table where id=#{id}")
        puts "TASK DELETED SUCCESSFULLY"
        puts "_________________________"
        display(sql)
      else
        puts "Please check the id"
      end
    }
  end

  def filter(date)
    sql = @c.query("select * from todo_table where date like '%#{date}%'")
    display(sql)
  end

  def sort
    sql = @c.query("Select * from todo_table order by date desc")
    display(sql)
  end

  # def note_exist(id)
  #   binding.pry
  #   notes = @c.query("select notes from todo_table where id ='#{id}'")
  #   notes.each do |notes|
  #     if ("#{notes["notes"]}" == "")
  #       puts "you can add notes"
  #       return true
  #     else
  #       puts " notes alredy added"
  #       return false
  #     end
  #   end
  # end

  def add_notes(id, note)
    #binding.pry
    sql = @c.query("update todo_table set notes='#{note}' where id='#{id}'")
    sql.each { |n|
      note = []
      note << "#{notes["notes"]}"
      puts note
    }
    puts "NOTE ADDED  SUCCESSFULLY"
    puts "_________________________"
    sql = @c.query("update todo_table set notes='#{note}' where id=#{id}")
    display(sql)
  end

  def mark_taskcomplete(id)
    sql = @c.query("update todo_table set status='1' where id='#{id}'")
    display_completedtask
  end

  def display_completedtask
    sql = @c.query("Select * from todo_table where status=1")
    display(sql)
  end

  def display_detail(id)
    sql = @c.query("select * from todo_table where id='#{id}'")
    display(sql)
  end

  def display_list
    sql = @c.query("Select id,task_todo from todo_table")
    display(sql)
  end

  def display(result)
    puts "TODO TASKS "
    print " " + "task_id".ljust(5)
    print " " + "Task Title".ljust(20)
    print " " + "Task todo ".ljust(40)
    print " " + "Notes/description".ljust(30)
    print " " + "Date".ljust(10)
    print " " + "Date to complete task".ljust(20)
    print " " + "Status".ljust(10)
    puts "\n\n"
    if result.count != 0
      result.each do |row|
        puts
        print " " + row["id"].to_s.ljust(5)
        print " " + row["task_title"].to_s.ljust(20)
        print " " + row["task_todo"].to_s.ljust(40)
        print " " + row["notes"].to_s.ljust(30)
        print " " + row["date"].to_s.ljust(10)
        print " " + row["Date_to_complete"].to_s.ljust(20)
        print " " + row["status"].to_s.ljust(10)
        puts "\n____________________________ "
      end
    else
      puts "\nNO Task FOUND\n"
    end
  end
end
