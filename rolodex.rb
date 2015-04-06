class Rolodex
  attr_accessor :contact_list
  def initialize
    @contact_list = []
    @contact_id = 0
  end

  def enter_first_name(contact)
    print "Enter the first name: "
    contact.first_name = gets.chomp
    if contact.first_name == ""
      puts "This is a required field."
      enter_first_name(contact)
    end
  end

  def enter_last_name(contact)
    print "Enter the last name: "
    contact.last_name = gets.chomp
    if contact.last_name == ""
      puts "This is a required field."
      enter_last_name(contact)
    end
  end

  def enter_email(contact)
    print "Enter the email address: "
    contact.email = gets.chomp.strip
    if contact.email == ""
      puts "This is a required field."
      enter_email(contact)
    end
  end

  def enter_notes(contact)
    print "Enter a note: "
    contact.notes = gets.chomp
    if contact.notes == ""
      puts "This is a required field."
      enter_notes(contact)
    end
  end

  def display_error
    puts "--------------------ERROR--------------------"
    puts "Invalid option. Please select another option."
    puts "--------------------ERROR--------------------"
    puts "                     ||                     "
    puts "           Select a  ||  new option         "
    puts "                     \\/                    "
    return false
  end

  def empty_list_error
    if @contact_list == []
      puts "\n\n\n"
      puts "--------------------ERROR--------------------"
      puts "     There are no contacts in your list.     "
      puts "--------------------ERROR--------------------"
      puts "                     ||                     "
      puts "           Select a  ||  new option         "
      puts "                     \\/                    "
      return true
    end
    return false
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
    return false if empty_list_error
    puts "Please enter a contact ID."
    display_all_contacts
    gets.chomp
  end

  def find_contact(id)
    contact = @contact_list.find {|contact| contact.id == id.to_i}
  end

  def confirm_input(id)
    return false if id == false
    return display_error unless contact = find_contact(id)
    puts "You have entered #{id}.  Is this correct?  Type 'yes' to continue to 'no' to return to the main menu."
    confirm = gets.chomp.strip.downcase
    if confirm == "no" || confirm == "n"
      return false
    elsif confirm == "yes" || confirm == "y"
      return contact
    else
      display_error
    end
  end

  def modify_existing_contact(contact)
    return false if contact == false

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
        display_error
      end
  end

  def delete_contact(contact)
    return display_error if contact == nil

    @contact_list.delete(contact)
  end

  def display_all_contacts
    return false if empty_list_error
    puts "---------------------------------------------"
    @contact_list.each do |contact|
      puts "Contact ##{contact.id}:  #{contact.first_name} #{contact.last_name}"
    end
    puts "---------------------------------------------"
  end

  def display_contact_info
    return false if empty_list_error
    display_all_contacts
    puts "Enter the ID number of the contact you wish to view."
    puts "---------------------------------------------"

    return display_error unless contact = find_contact(gets.chomp.to_i)

    puts "---------------------------------------------"
    puts "Contact ##{contact.id}"
    puts "#{contact.first_name} #{contact.last_name}"
    puts "Email: #{contact.email}"
    puts "Notes: #{contact.notes}"
    puts "---------------------------------------------"
  end

  def display_attributes
    puts "[1] = First Name"
    puts "[2] = Last Name"
    puts "[3] = Email"
    puts "[4] = Notes"
    puts "---------------------------------------------"
  end

  def display_contacts_with_attribute
    return false if empty_list_error
    puts "Select a number to see that info for all contacts."
    display_attributes

    case gets.chomp
      when "1"
        puts "-------- * ~ * -- FIRST NAMES -- * ~ * ------"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.first_name}"
        end
      when "2"
        puts "-------- * ~ * -- LAST NAMES -- * ~ * -------"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.last_name}"
        end
      when "3"
        puts "------ * ~ * -- EMAIL ADDRESSES -- * ~ * ----"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.email}"
        end
      when "4"
        puts "----------- * ~ * -- NOTES -- * ~ * ---------"
        @contact_list.each do |contact|
          puts "Contact ##{contact.id}: #{contact.notes}"
        end
      else
        display_error
      end
    end
  end