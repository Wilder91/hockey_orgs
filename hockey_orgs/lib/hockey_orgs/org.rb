class Org 
    attr_accessor :id, :name, :abbreviation, :stadium, :city, :founding, :division

    @@all = []

    def initialize(id, name, abbreviation, stadium, city, founding, division)
        @id = id
        @name = name 
        @abbreviation = abbreviation
        @stadium = stadium 
        @city = city
        @founding = founding
        @division = division 
        @@all << self
    end

    def self.all 
        @@all
    end

    def self.get_arena(input)
        #binding.pry
        puts "The #{self.all[input].name} play at the #{self.all[input].stadium} in #{@@all[input].city}."
    end

    def self.get_founding(input)
        puts "The #{self.all[input].name} were founded in #{self.all[input].founding}."
    end

    def self.get_division(input)
        puts "The #{self.all[input].name} play in the #{self.all[input].division} Division."
    end

    

    

    
end