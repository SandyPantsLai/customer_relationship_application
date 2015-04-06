class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :notes

  def initialize(id, first_name, last_name, email, notes)
    @id = id
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
    nil if confirm == "no" || confirm == "n"
    else @contact_list.find {|contact| contact.id == id.to_i}
  end

  def modify_existing_contact(contact)
    return false if contact == nil
    puts "What would you like to edit?"
    puts "[1] = First Name"
    puts "[2] = Last Name"
    puts "[3] = Email"
    puts "[4] = Notes"

    case gets.chomp
      when "1"
        puts "Enter the first name."
        contact.first_name = gets.chomp
      when "2"
        puts "Enter the last name."
        contact.last_name = gets.chomp
      when "3"
        puts "Enter the email address."
        contact.email = gets.chomp
      when "4"
        puts "Enter some notes for this contact."
        contact.notes = gets.chomp
      else
        false
      end
  end

  def delete_contact(contact)
    return false if contact == nil
    @contact_list.delete(contact)
  end

  def display_all_contacts
    @contact_list.each do |contact|
      puts "Contact ID: #{contact.id} #{contact.first_name} #{contact.last_name}"
    end
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
    @company.modify_existing_contact(@company.confirm_input(@company.choose_contact)) if user_selected == 2
    @company.delete_contact(@company.confirm_input(@company.choose_contact)) if user_selected == 3
    @company.display_all_contacts if user_selected == 4
    @company.display_contact_info if user_selected == 5
    @company.display_contacts_with_attribute if user_selected == 6
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
    while true
      print_main_menu
      user_selected = gets.to_i
      break if call_option(user_selected)
    end
  end
end

CRM.new("Bitmaker Labs")