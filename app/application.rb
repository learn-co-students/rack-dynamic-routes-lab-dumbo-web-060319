
class Application 

@@items = [] 
apple = Item.new("Apple", 25)
@@items << apple 

    def call(env)
        resp = Rack::Response.new 
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            actual_item = req.path.split("/items/").last 
            hasOrNot = 0
            @@items.each do |thing|
                if thing.name == actual_item
                    resp.write thing.price 
                    hasOrNot = 1
                end 
            end
            if hasOrNot == 0 
                resp.status = 400 
                resp.write "Item not found"
            end 
        else 
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end


end