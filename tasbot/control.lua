function calc_distance(a, b)
    return math.sqrt((a.x - b.x) ^ 2 + (a.y - b.y))
end

script.on_event(defines.events.on_tick, function(event)
    local best_distance = nil
    local best_entity = nil

    local player = game.players[1]
    local surface = game.surfaces[1]

    for _, entity in pairs(surface.find_entities_filtered {
        name = {'dead-dry-hairy-tree', 'dead-grey-trunk', 'dead-tree-desert', 'dry-hairy-tree', 'dry-tree', 'tree-01',
                'tree-02', 'tree-02-red', 'tree-03', 'tree-04', 'tree-05', 'tree-06', 'tree-06-brown', 'tree-07',
                'tree-08', 'tree-08-brown', 'tree-08-red', 'tree-09', 'tree-09-brown', 'tree-09-red', 'rock-big',
                'rock-huge', 'sand-rock-big'}
    }) do
        local distance = calc_distance(player.position, entity.position)
        if best_distance == nil or distance < best_distance then
            -- game.print("better: " .. entity.position.x .. ", " .. entity.position.y)
            best_distance = distance
            best_entity = entity
        end
    end

    game.print(best_distance)

    if best_entity ~= nil then
        -- if player.mine_entity(best_entity) then
        --     player.walking_state.walking = false
        -- else
        -- x=east y=south
        -- defines.direction.north
        -- defines.direction.northeast
        -- defines.direction.east
        -- defines.direction.southeast
        -- defines.direction.south
        -- defines.direction.southwest
        -- defines.direction.west
        -- defines.direction.northwest
        local p = player.position
        local e = best_entity.position
        local bd = player.build_distance
        local direction = nil
        local north = false
        local east = false
        local south = false
        local west = false

        if p.x + bd < e.x then
            east = true
        end
        if p.x - bd > e.x then
            west = true
        end
        if p.y + bd < e.y then
            south = true
        end
        if p.y - bd > e.y then
            north = true
        end

        if north and east then
            direction = defines.direction.northeast
        elseif south and east then
            direction = defines.direction.southeast
        elseif south and west then
            direction = defines.direction.southwest
        elseif north and west then
            direction = defines.direction.northwest
        elseif north then
            direction = defines.direction.north
        elseif east then
            direction = defines.direction.east
        elseif south then
            direction = defines.direction.south
        else
            direction = defines.direction.west
        end

        player.walking_state = {
            walking = true,
            direction = direction
        }
        -- end
    end
end)
