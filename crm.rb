class CRM
  def initialize
    main_menu
  end

  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    delete_contact if user_selected == 3
    display_all_contacts if user_selected == 4
    display_contact_info if user_selected == 5
    display_contacts_with_attribute if user_selected == 6
    exit if user_selected == 7

  end

  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all contact names"
    puts "[5] Display info for contact"
    puts "[5] Display an attribute for all contacts"
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end
end

CRM.new