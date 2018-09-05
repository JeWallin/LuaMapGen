
function newRoom()

    local room = {};

    room.position = {};
    room.position.x = 0;
    room.position.y = 0;

    room.size = {};
    room.size.w = 1;
    room.size.h = 1;

    function room:Colliding( other )
        
        local isColliding = (math.abs(self.position.x - other.position.x)*2) < (self.size.w + other.size.w)
                        and (math.abs(self.position.y - other.position.y)*2) < (self.size.h + other.size.h);

        return isColliding;

    end

    function room:GetCenter()
        local point = {};

        point.x = math.floor(self.position.x + (self.size.w / 2));
        point.y = math.floor(self.position.y + (self.size.h / 2));

        return point;
    end


    return room;
end