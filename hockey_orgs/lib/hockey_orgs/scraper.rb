
URL = 'https://statsapi.web.nhl.com/api/v1/teams/'
class Scraper



    def self.create_orgs #instantiates the organizations
        #binding.pry
        response = RestClient.get(URL)
        data = JSON.parse(response.body)["teams"]
        x = data.sort_by {|o| o["name"]}
        x.each.with_index(1) do |o, i|
           Org.new(i, o["name"], o["abbreviation"], o["venue"]["name"], o["venue"]["city"], o["firstYearOfPlay"], o["division"]["name"])
        end
    end

    def self.list_orgs  #numbered list of organizations for selection
        Org.all.each do |o| 
            #binding.pry
            puts "#{o.id}. #{o.name}"
        end
    end
   

    

    
end
