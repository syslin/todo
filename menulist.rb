require "pry"

class TodoApplication
  def menu
    puts "ENTER YOUR CHOICE TO PERFORM THE OPERATION"
    list = ["1:TO CREATE NEW TODO TASK", "2:TO VIEW THE TODO LIST", " 3:QUIT"]
    puts list
    select_menu
  end

  def select_menu
    input = gets.chomp.to_i
    until input <= 3
      puts "Please choose the number from 1-3"
      input = gets.chomp.to_i
    end
    case (input)
    when 1
      create_new_todo
      goto select_menu
    when 2
      view_todo_list
      goto select_menu
    when 3
      puts "THANK YOU FOR YOUR TIME"
    end
  end

  def create_new_todo
  end
end

obj = MenuList.new
obj.menu
