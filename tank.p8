pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- tank's base properties
tank = {
    x = 64, -- x position
    y = 64, -- y position
    orientation = 0, -- facing direction of the tank, 0 is right
    turret_orientation = 0, -- turret's facing direction relative to the tank
    speed = 0,
    max_speed = 2,
    acc = 0.1,
    dec = 0.05
}

-- utility function to rotate a point around another point
function rotate_point(px, py, ox, oy, angle)
    local radians = angle / 360
    local cos_angle = cos(radians)
    local sin_angle = sin(radians)
    return cos_angle * (px - ox) - sin_angle * (py - oy) + ox,
           sin_angle * (px - ox) + cos_angle * (py - oy) + oy
end

-- draw tank with rotation
function draw_tank(tank)
    -- tank base dimensions
    local width, height = 6, 4
    local half_w, half_h = width / 2, height / 2
    
    -- calculate corners of the tank base
    local corners = {
        {x = -half_w, y = -half_h},
        {x = half_w, y = -half_h},
        {x = half_w, y = half_h},
        {x = -half_w, y = half_h}
    }
    
    -- rotate corners
    for i, corner in ipairs(corners) do
        local rx, ry = rotate_point(corner.x, corner.y, 0, 0, tank.orientation)
        corners[i].x, corners[i].y = rx + tank.x, ry + tank.y
    end
    
    -- draw tank base
    for i = 1, #corners do
        local next_index = i % #corners + 1
        line(corners[i].x, corners[i].y, corners[next_index].x, corners[next_index].y, 8) -- color 8 for example
    end
    
    -- turret (simple line for now)
    local turret_length = 4
    local turret_end_x, turret_end_y = rotate_point(turret_length, 0, 0, 0, tank.orientation + tank.turret_orientation)
    turret_end_x, turret_end_y = turret_end_x + tank.x, turret_end_y + tank.y
    line(tank.x, tank.y, turret_end_x, turret_end_y, 9) -- color 9 for example
end

function _update()
    -- example controls for tank
    if (btn(0)) then tank.orientation -= 1 end -- turn left
    if (btn(1)) then tank.orientation += 1 end -- turn right
    if (btn(2)) then tank.turret_orientation -= 1 end -- turret left
    if (btn(3)) then tank.turret_orientation += 1 end -- turret right
    if btn(4) then
    	tank.speed = min(tank.speed + tank.acc, tank.max_speed)
    else
    end
    if tank.speed ~= 0 then
    	radians = tank.orientation / 360
    	dx = cos(tank.orientation) * tank.speed
    	dy = sin(tank.orientation) * tank.speed
    	tank.x += dx
    	tank.y += dy
    end
end

function _draw()
    cls() -- clear screen
    draw_tank(tank)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
