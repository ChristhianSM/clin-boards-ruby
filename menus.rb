def main_menu(options)
  puts options.join("  |  ")
  print "> "
  action, id = actions_boards
  [action, id]
end

def first_menu(options)
  puts "List options: #{options.join('  |  ')}"
end

def second_menu(message, options)
  puts "#{message} #{options.join('  |  ')}"
  puts "<-- back"
  print "> "
  action, id = actions_list
  [action, id]
end

def board_form(tipo = "create")
  print "Name: "
  name = gets.chomp
  if tipo == "create"
    while name.empty?
      puts "\n----- Enter a name of board to continue -----\n\n"
      print "Name: "
      name = gets.chomp
    end
  end

  while validate_name_board(@storage.boards, name)
    puts "\n----- Name has already been taken -----\n\n".red
    print "Name: "
    name = gets.chomp
  end

  print "Description: "
  description = gets.chomp
  { name: name, description: description }
end

def show_select_list(board_found)
  puts "Select a list:"
  board_found.lists.each do |list|
    if list == board_found.lists[board_found.lists.size - 1]
      print "#{list.name}\n"
    else
      print "#{list.name} | "
    end
  end
  print "> "
end

def list_form(tipo = "create")
  print "Title: "
  title = gets.chomp
  if tipo == "create"
    while title.empty?
      puts "\n----- Enter a name to create a card -------\n\n".red
      print "Title: "
      title = gets.chomp
    end
  end

  print "Members: "
  members = gets.chomp
  print "Labels: "
  labels = gets.chomp
  print "Due Date: "
  due_date = gets.chomp
  due_date = validate_date(due_date)

  { title: title, members: [members], labels: [labels], due_date: due_date }
end
