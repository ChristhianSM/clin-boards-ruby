# checklist
def checklist(board, id_card, storage)
  card_found = ""
  board.lists.each do |list|
    list.cards.each do |card|
      card_found = card if card.id == id_card
    end
  end

  if card_found == ""
    puts "\n\n-------Enter a Id Valid--------\n\n".red
    return
  end

  action = ""
  until action == "back"
    puts "\nCard: #{card_found.title}".green
    puts "-------------------------------------"

    show_check(card_found)

    options = ["add", "toggle INDEX", "delete INDEX"]
    action, id = second_menu("Checklist options:", options)

    show_select_checklist(action, card_found, id, storage)
  end
end

def show_check(card_found)
  if card_found.checklist.size.zero?
    puts "\n    THERE IS NO TASKS TO SHOW \n".red
  else
    card_found.checklist.each_with_index do |check, index|
      if check[:completed]
        puts "[x] #{index + 1}. #{check[:title]}"
      else
        puts "[ ] #{index + 1}. #{check[:title]}"
      end
    end
  end
  puts "-------------------------------------"
end

def show_select_checklist(action, card_found, id, storage)
  case action
  when "add" then add_check(card_found, storage)
  when "toggle" then toggle_check(card_found, id, storage)
  when "delete" then delete_check(card_found, id, storage)
  when "back" then puts "Regresando"
  else
    puts "\n------- Invalid Option -------\n".red
  end
end

def add_check(card_found, storage)
  print "Title: "
  title = gets.chomp
  while title.empty?
    puts "\n-------Ingrese nombre del check-------\n\n"
    print "Title: "
    title = gets.chomp
  end
  hash_check = { title: title, completed: false }
  storage.add_check_to_card(card_found, hash_check)
end

def toggle_check(card_found, index, storage)
  if validate_index_check(card_found, index)
    storage.toggle_check_to_card(card_found, index)
  else
    puts "\n\n-------Enter a index correct--------\n\n".red
  end
end

def delete_check(card_found, index, storage)
  if validate_index_check(card_found, index)
    storage.remove_check_from_card(card_found, index)
  else
    puts "\n\n-------Enter a index correct--------\n\n".red
  end
end
