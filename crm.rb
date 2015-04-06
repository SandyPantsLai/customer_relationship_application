class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :notes

  def initialize(id, first_name, last_name, email, notes)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end
end

class Rolodex
  def initialize
    @contact_list = []
    @contact_id = 0
  end

  def add_new_contact
  print "Enter First Name: "
  first_name = gets.chomp
  print "Enter Last Name: "
  last_name = gets.chomp
  print "Enter Email Address: "
  email = gets.chomp.strip
  print "Enter a Note: "
  notes = gets.chomp
  @contact_id += 1
  @contact_list.push(Contact.new(@contact_id, first_name, last_name, email, notes))
  end
end

class CRM
  def initialize(company)
    puts "Welcome to #{company} Customer Relations App.  Please choose a menu item."
    @company = Rolodex.new
    main_menu
  end

  def call_option(user_selected)
    @company.add_new_contact if user_selected == 1
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
    puts "[6] Display an attribute for all contacts"
    puts "[7] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end
end

CRM.new("Bitmaker Labs")