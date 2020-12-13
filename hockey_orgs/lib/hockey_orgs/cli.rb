
class Cli

    def call
        Cli.hello
        Scraper.create_orgs
        Cli.list_orgs
        Cli.org_menu
    end

    def self.hello 
        puts "Hello and welcome to Hockey Orgs! Below you will find a list of all active NHL franchises:"
        puts " "
        sleep(1)
    end

    def self.list_orgs  #prints a numbered list of organizations for selection
        Org.all.each do |o| 
            #binding.pry
            puts "#{o.id}. #{o.name}"
        end
    end

    def self.org_menu #top level menu, choose an
        puts ""
        puts "Enter the number of the team you would like to learn about, or type exit to quit:"
        input = gets.chomp
        @i = input.to_i - 1
        if input.downcase == 'exit'
           self.goodbye
        elsif @i < 0 or @i >= Org.all.length
            puts ""
            puts "invalid input"
            sleep(1.2)
            puts ""
            self.list_orgs
            self.org_menu
        else 
            puts ""
            self.org_options(@i)
        end
    end

    def self.org_options(i) #provide options for learning about the organization
        name = Org.all[@i].name 
        puts "What would you like to know about the #{name}?(type exit to return to team selection)"
        puts ''
        puts "1. Arena Name 2. Year of founding 3. What division do they play in?"
        self.org_choice
    end 
    
    def self.org_choice
        choice = gets.chomp 
        case choice 
        when "exit"
            puts "" 
            puts "returning you to main menu"
            self.list_orgs
            Cli.org_menu
        when '1'
            Org.get_arena(@i)
            puts ""
            self.more_info
        when '2'
            Org.get_founding(@i)
            sleep(0.8)
            self.same_founding(@i)
        when '3'
            Org.get_division(@i)
            puts ""
            self.more_info
        else 
            #binding.pry
            puts ""
            puts "Invalid input"
            puts ""
            self.org_options(@i)
        end
    end

    def self.more_info
        puts "Would you like more info on The #{Org.all[@i].name}?(Please type Y or N)"
        input = gets.chomp
            case input 
            when 'y'
                self.org_options(@i)
            when 'n'
                puts "Returning you to the main menu"
                sleep(0.5)
                puts ""
                self.list_orgs
                self.org_menu
            else 
                puts "Invalid input! Please type Y or N"
                self.more_info
            end 
    end
    
    def self.same_founding(input) #check if other teams were founded the same year
        teams = []
        arr = []
        puts "Would you like to see all other teams founded that year?(please type Y or N)"
        input = gets.chomp.downcase
        case input 
        when 'y'
            Org.all.each do |o|
                if o.founding == Org.all[@i].founding && o.name != Org.all[@i].name
                    arr << o.name
                end
            end
            if arr.size > 0 
                puts arr
            else
                #binding.pry
                puts "The #{Org.all[@i].name} were the only team founded in #{Org.all[@i].founding}" 
            end
            self.more_info
        when 'n'
            self.more_info
        else 
            puts ""
            puts "Invalid input"
            puts ""
            self.same_founding(@i)
        end
    end

    

    def self.goodbye 
        puts ""
        puts "Thank you for your interest in the NHL, it was an honor to serve you." 
    end

end

