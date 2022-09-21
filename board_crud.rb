require_relative "board"
require_relative "storage"

def show_menu_main_options(action, id, storage)
  case action
  when "create" then create_board(storage)
  when "show"
    if validate_id(id, storage.boards)
      show_board(id, storage)
    else
      puts "\n\n------ Enter a valid ID ------\n\n".red
    end
  when "update" then update_board(id, storage)
  when "delete" then delete_board(id, storage)
  when "exit" then welcolme_menu_exit(3, "Thanks for using CLIn Boards")
  else
    puts "\n\n----- Invalid Option -----\n\n".red
  end
end

def create_board(storage)
  board_hash = board_form
  new_board = Board.new(**board_hash)
  storage.add_board(new_board)
end

def update_board(id, storage)
  if validate_id(id, storage.boards)
    board_hash = board_form("update")
    storage.update_board(id, board_hash)
  else
    puts "\n\n----- Enter a valid ID -----\n\n".red
  end
end

def delete_board(id, storage)
  if validate_id(id, storage.boards)
    storage.delete_board(id)
  else
    puts "\n\n----- Enter a valid ID -----\n\n".red
  end
end

def show_board(id, storage)
  action = ""
  board_found = storage.boards.find { |board| board.id == id }
  until action == "back"

    show_tables_lists(board_found)

    list_options = ["create-list", "update-list LISTNAME", "delete-list LISTNAME"]
    card_options = ["create-card", "checklist ID", "update-card ID", "delete-card ID"]
    first_menu(list_options)
    action, id = second_menu("Card options:", card_options) # action, id o string
    return if action == "back"

    # Validar a cual menu ingresar
    array_list_options = %w[create-list update-list delete-list]
    array_card_options = %w[create-card checklist update-card delete-card]
    if array_list_options.include?(action)
      show_menu_list_options(action, board_found, id)
    elsif array_card_options.include?(action)
      show_menu_card_options(action, board_found, id)
    else
      puts "\n\n----- Invalid Option -----\n\n".red
    end
  end
end
