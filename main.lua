
require "worldGenerator"
require "room"

function main()

    local size = 36;
    local width = size;
    local height = size;
    math.randomseed(os.time());
    local world = generateWorld( width, height );
    local rooms = generateRooms(4, 4, 4, width, height);

    -- not needed but to clerify (passes by ref.)
    world = addRoomsToWorld(world, rooms);
    world = generatePaths(world, rooms);
    world = removeWalls(world);
    print(#rooms);
    
    printWorld(world);
   

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
