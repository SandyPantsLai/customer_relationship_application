require_relative "contact"#require "./contact" is an alternative or load "contract.rb"(though it will reload this each time.  With require, once "required", not reloaded.)
require_relative "rolodex"

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
    puts "============================================="
    puts "~~~~ * ~ * ~ * ~ * Main Menu * ~ * ~ * ~ * ~~"
    puts "============================================="
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all contact names"
    puts "[5] Display info for contact"
    puts "[6] Display an attribute for all contacts"
    puts "[7] Exit"
    puts "---------------------------------------------"
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