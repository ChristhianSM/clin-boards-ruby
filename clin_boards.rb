require "json"
require "terminal-table"
require_relative "board"
require_relative "board_crud"
require_relative "helpers"
require_relative "storage"
require_relative "list"
require_relative "list_crud"
require_relative "card_crud"
require_relative "checklist_crud"
require_relative "menus"
require "colorize"

class ClinBoards
  def initialize(filename = "store.json")
    # Complete this
    @storage = Storage.new(filename)
  end

  def start
    # Complete this
    action = ""
    welcolme_menu_exit(6, "Welcome to CLIn Boards")
    until action == "exit"
      show_table(title: "CLIn Boards", list: @storage.boards, headings: ["ID", "Name", "Description", "Lists(#cards)"],
                 message: "THERE IS NO BOARDS TO SHOW", columns: 6)
      options = ["Create", "Show ID", "Update ID", "Delete ID", "Exit"]
      action, id = main_menu(options)

      show_menu_main_options(action, id, @storage)

    end
  end

  def show_tables_lists(board_found)
    if board_found.lists.size.zero?
      puts "\n\n -------- THERE IS NO LIST TABLE TO SHOW -------\n\n".red
    else
      board_found.lists.each do |list|
        show_table(title: list.name, list: list.cards,
                   headings: ["ID", "Title", "Members", "Labels", "Due Date", "Checklist"],
                   message: "THERE IS NO CARDS TO SHOW", columns: 6)
      end
    end
  end

  def show_menu_list_options(action, board_found, id)
    case action
    when "create-list" then create_list(board_found.id, @storage)
    when "update-list" then update_list(board_found, id, @storage) # listname
    when "delete-list" then delete_list(board_found, id, @storage) # listname
    end
  end

  def show_menu_card_options(action, board_found, id)
    case action
    when "create-card" then create_card(board_found, @storage)
    when "checklist" then checklist(board_found, id, @storage)
    when "update-card" then update_card(board_found, id, @storage)
    when "delete-card" then delete_card(board_found, id, @storage)
    end
  end

  private

  def welcolme_menu_exit(espacioado, message)
    puts ""
    puts "#{' ' * 30}####################################".green
    puts "#{' ' * 30}##{' ' * espacioado}#{message}#{' ' * espacioado}#".green
    puts "#{' ' * 30}####################################".green
    puts "\n"
  end

  def show_table(title:, list:, headings:, message:, columns:)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    if list.size.zero?
      table.add_row [{ value: message.red, colspan: columns, alignment: :center }]
    else
      table.rows = list.map(&:details)
    end
    puts table
  end

  def actions_boards
    action, id = gets.chomp.downcase.split # "show 1" -> ["show", "1"]
    if id.to_i.positive?
      [action, id.to_i]
    else
      [action, id]
    end
  end

  def actions_list
    action, *id = gets.chomp.downcase.split # delete l, delete-list Feedback
    return action if action == "back"

    if id.length > 1
      [action, id.join(" ")]
    elsif id.join.to_i.positive?
      [action, id.join.to_i]
    else
      [action, id.join]
    end
  end
end

# get the command-line arguments if neccesary
filename = ARGV.shift
if filename.nil?
  app = ClinBoards.new
  app.start
else
  _name, extension = filename.split(".")
  if extension == "json"
    File.write(filename, []) unless File.exist?(filename)
    app = ClinBoards.new(filename)
    app.start
  else
    puts "Insert file valid [name_file].json, example: store.json"
  end
end
