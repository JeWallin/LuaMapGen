
require "worldGenerator"
require "room"

function main()

    io.write("input map size: ");

    local size = io.read("*number");
    io.write("Enter number of rooms : ");
    local numberOfRooms = io.read("*number");
    io.write("Enter room size : ");
    local roomSize = io.read("*number");
    local roomSizeX = roomSize;
    local roomSizeY = roomSize;
    local width = size;
    local height = size;
    math.randomseed(os.time());
    local world;
    while true do
        
        world = generateWorld( width, height );
        local rooms = generateRooms(numberOfRooms, roomSizeX, roomSizeY, width, height);

        -- not needed but to clerify (passes by ref.)
        world = addRoomsToWorld(world, rooms);
        world = generatePaths(world, rooms);
        world = removeWalls(world);
        
        print(#rooms);
        
        printWorld(world);
        io.write("Happy with the map? (y/n) : ");
        local input = io.read();

        if input == 'y' then
            break;
        end
    end

    io.write("do you want to save it? (y/n) : ");
    local answer = io.read();

    if answer == 'y' then

        io.write("Name of map : ")
        local mapName = io.read();

        local file = io.open(mapName, "w");
        printWorldToFile(file,world);
        file:close();

    end

   

end

function printWorldToFile( file, world )

    for i = 0, #world do

        for j = 0, #world[i] do

            if world[i][j] == 2 then
                file:write(".");
            elseif world[i][j] == 1 then
                file:write("X");
            else
                file:write(" ");
            end
            

        end
        
        file:write("\n");

    end

end

function printWorld( world )

    for i = 0, #world do

        for j = 0, #world[i] do

            if world[i][j] == 2 then
                io.write(".");
            elseif world[i][j] == 1 then
                io.write("X");
            else
                io.write(" ");
            end
            

        end
        
        io.write("\n");

    end

end



main();
