require "room"

function generateWorld( x, y )
    local map = {};

    for i = 0, x do
        map[i] = {};

        for j = 0, y do
            map[i][j] = 1;

        end
    end

    return map;
end

function generateRooms( numberOfRooms, RoomSizeX, RoomSizeY, worldX, worldY)
    local rooms = {};

    for i = 0, numberOfRooms-1 do
        local room = newRoom();

        room.size.w = 3 + math.random(RoomSizeX);
        room.size.h = 3 + math.random(RoomSizeY);

        room.position.x = 1 + math.random(worldX - room.size.w - 2 );
        room.position.y = 1 + math.random(worldY - room.size.h - 2 );

        rooms[i] = room;
    end

    return rooms;
end

function addRoomsToWorld( map, rooms )

    for x = 0, #map do

        for y = 0, #map[x] do

            local tempRoom = newRoom();
            tempRoom.position.x = x;
            tempRoom.position.y = y;

            tempRoom.size = {w= 1, h=1};

            for room = 0, #rooms do
                if rooms[room]:Colliding(tempRoom) then
                    map[x][y] = 2;
                end
            end

        end

    end

    return map;
end

function generatePaths( map, rooms )
    for i = 0, #rooms-1 do

        local start = rooms[i]:GetCenter();
        local goal  = rooms[i+1]:GetCenter();


        while not (start.x == goal.x and start.y == goal.y) do

            if start.y == goal.y then

                local dif = goal.x - start.x;
                dif = dif / math.abs(dif);
                start.x = start.x + dif;

            else

                local dif = goal.y - start.y;
                dif = dif / math.abs(dif);
                start.y = start.y + dif;
                
            end
            map[start.x][start.y] = 2;
            
        end
    end
    return map;
end

function removeWalls( map )
    local toRemove = {};

    for x = 0, #map do
        for y = 0, #map[x] do
            if map[x][y] == 1 then
                local count = 0;
                left = math.max(0, x-1);
                up = math.max(0, y-1);
                down = math.min(y+1, #map[x]);
                right = math.min(x+1, #map);
                
                if map[left][y] == 2 or map[right][y] == 2 or map[x][up] == 2 or  map[x][down] == 2 then
                    count = 1;
                end

                if count == 0 then
                    toRemove[#toRemove+1] = {px = x, py = y};
                end
            end
        end
    end

    for i = 1, #toRemove do
        local dot = toRemove[i];
        map[dot.px][dot.py] = 0;
    end

    return map;
end