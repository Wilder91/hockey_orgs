
class Cli

    def call
        Scraper.create_orgs
        Scraper.list_orgs
        Cli.org_menu
    end

    def self.org_menu #top level menu, choose an
        puts "Enter the number of the team you would like to learn about(type exit to quit)"
        input = gets.chomp
        @i = input.to_i - 1
        if input == 'exit'
            puts ""
            puts "Thank you for your interest in the NHL, it was an honor to serve you." 
        elsif @i < 0 or @i >= 31
            puts ""
            puts "invalid input"
        else 
            puts ""
            self.org_options(@i)
        end
    end

    def self.org_options(i) #provide options for learning about the organization
        name = Org.all[@i].name 
        puts "What would you like to know about the #{name}?(type exit to return to team selection)"
        puts "1. Arena Name 2. Year of founding 3. What division do they play in?"
        self.org_choice
        input = gets.chomp
            case input 
            when 'y'
                self.org_options(i)
            when 'n'
                self.org_menu
            else 
                puts "invalid input please enter y or n"
                self.org_options(i)
            end
        end
    
    def self.same_founding(input) #check if other teams were founded the same year
        teams = []
        arr = []
        puts "Would you like to see all teams founded that year?(please type y or n)"
        input = gets.chomp.downcase
        case input 
        when 'y'
            Org.all.each do |o|
                #binding.pry
                if o.founding == Org.all[@i].founding 
                    arr << o.name
                end
            end
            puts arr
            Cli.org_menu
        when 'n'
            self.org_options(@i)
        else 
            "Please type Y or N"
        end
    end
    
    def self.org_choice
        choice = gets.chomp 
        if choice == "exit"
            puts "" 
            puts "returning you to main menu"
            Scraper.list_orgs
            self.org_menu
        elsif choice == '1'
            puts ""
            Org.get_arena(@i)
        elsif choice == '2'
                puts ""
                Org.get_founding(@i)
                self.same_founding(@i)
        elsif choice == '3'
                puts ""
                Org.get_division(@i)
        end
        self.org_options(@i)
    end

end

