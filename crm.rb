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

  def enter_first_name(contact)
    print "Enter First Name: "
    contact.first_name = gets.chomp
    if contact.first_name == ""
      puts "This is a required field."
      enter_first_name(contact)
    end
  end

  def enter_last_name(contact)
    print "Enter Last Name: "
    contact.last_name = gets.chomp
    if contact.last_name == ""
      puts "This is a required field."
      enter_last_name(contact)
    end
  end

  def enter_email(contact)
    print "Enter Email Address: "
    contact.email = gets.chomp.strip
    if contact.email == ""
      puts "This is a required field."
      enter_email(contact)
    end
  end

  def enter_notes(contact)
    print "Enter a Note: "
    contact.notes = gets.chomp
    if contact.notes == ""
      puts "This is a required field."
      enter_notes(contact)
    end
  end

  def add_new_contact
    @contact_id += 1
    contact = Contact.new(@contact_id, "", "", "", "")
    enter_first_name(contact)
    enter_last_name(contact)
    enter_email(contact)
    enter_notes(contact)
    @contact_list.push(contact)
  end

  def choose_contact
    puts "Please enter a contact ID."
    display_all_contacts
    gets.chomp
  end

  def confirm_input(id)
    puts "You have entered #{id}.  Is this correct?  Type 'yes' to continue to 'no' to return to the main menu."
    confirm = gets.chomp.strip.downcase
    return nil if confirm == "no" || confirm == "n"
    else @contact_list.find {|contact| contact.id == id.to_i}
  end

  def modify_existing_contact(contact)
    return false if contact == nil
    puts "What would you like to edit?"
    display_attributes

    case gets.chomp
      when "1"
        enter_first_name(contact)
      when "2"
        enter_last_name(contact)
      when "3"
       enter_email(contact)
      when "4"
        puts "Enter some notes for this contact."
        enter_notes(contact)
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
      puts "Contact ##{contact.id}:  #{contact.first_name} #{contact.last_name}"
    end
  end

  def display_contact_info
    display_all_contacts
    puts "Enter the ID number of the contact you wish to view."

    contact = @contact_list.find {|contact| contact.id == gets.chomp.to_i}
    puts "Contact ##{contact.id}"
    puts "#{contact.first_name} #{contact.last_name}"
    puts "Email: #{contact.email}"
    puts "Notes: #{contact.notes}"
  end

  def display_attributes
    puts "[1] = First Name"
    puts "[2] = Last Name"
    puts "[3] = Email"
    puts "[4] = Notes"
  end

  def display_contacts_with_attribute
    puts "Select a number to see that info for all contacts."
    display_attributes
    case gets.chomp
      when "1"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.first_name}"
        end
      when "2"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.last_name}"
        end
      when "3"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.email}"
        end
      when "4"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.notes}"
        end
      else
        false
      end
  end
end

class CRM

  def self.run(company)
    crm = CRM.new(company)
    crm.main_menu
  end

  def initialize(company)
    puts "Welcome to #{company} Customer Relations App.  Please choose a menu item."
    @company = Rolodex.new
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

CRM.run("Bitmaker Labs")