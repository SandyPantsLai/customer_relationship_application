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
    puts "Invalid option.  Please select another option.\n"
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
    puts "Please enter a contact ID."
    display_all_contacts
    gets.chomp
  end

  def confirm_input(id)
    return display_error unless contact = @contact_list.find {|contact| contact.id == id.to_i}
    puts "You have entered #{id}.  Is this correct?  Type 'yes' to continue to 'no' to return to the main menu."
    confirm = gets.chomp.strip.downcase
    return false if confirm == "no" || confirm == "n"
    else contact
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
    @contact_list.each do |contact|
      puts "Contact ##{contact.id}:  #{contact.first_name} #{contact.last_name}"
    end
  end

  def display_contact_info
    display_all_contacts
    puts "Enter the ID number of the contact you wish to view."

    contact = @contact_list.find {|contact| contact.id == gets.chomp.to_i}
    return display_error if contact == nil

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
        puts "Invalid option"
        false
      end
    end
  end