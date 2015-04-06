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
  attr_accessor :contact_list
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

  def choose_contact
    puts "Please enter a contact ID."
    display_all_contacts
    gets.chomp
  end

  def confirm_input(id)
    puts "You have entered #{id}.  Is this correct?  Type 'yes' to continue to 'no' to return to the main menu."
    confirm = gets.chomp.strip.downcase
    id = nil if confirm == "no" || confirm = "n"
    else id
  end

  def modify_existing_contact(id)
    # return main_menu if id == nil
  end

  def display_all_contacts
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
    @company.modify_existing_contact(@company.confirm_input(@company.choose_contact))if user_selected == 2
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