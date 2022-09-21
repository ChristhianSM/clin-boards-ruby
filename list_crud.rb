require_relative "storage"
require_relative "list"

def create_list(id, storage)
  print "Name: "
  name = gets.chomp
  while name.empty?
    puts "\n\n----- Enter a name of list to continue -----\n\n".red
    print "Name: "
    name = gets.chomp
  end

  while validate_name_list(storage.boards, name, id)
    puts "\n\n----- Name has already been taken -----\n\n".red
    print "Name: "
    name = gets.chomp
  end

  new_list = List.new(**{ name: name })
  storage.add_list_to_board(id, new_list)
end

# TODO: FIX VALIDATION
def update_list(board_found, listname, storage)
  if validate_list_name(listname, board_found)
    print "Name: "
    name = gets.chomp
    storage.update_list_to_board(board_found, listname, **{ name: name })
  else
    puts "\n\n----- Enter a List Name Valid ------\n\n".red
  end
end

def delete_list(board_found, listname, storage)
  if validate_list_name(listname, board_found)
    storage.delete_list_to_board(board_found, listname)
  else
    puts "\n\n----- Enter a List Name Valid ------\n\n".red
  end
end
