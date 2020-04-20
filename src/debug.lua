function Round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function DrawInfo(Bodies)
    local font = love.graphics.newFont("fonts/Hack-Bold.ttf", 15)
    love.graphics.setColor(1, 1, 1)

    local finalPos = 0

    for i = 1, #Bodies do
        local body = Bodies[i]
        local info = love.graphics.newText(font, body.name .. ": " .. Round(body.position:dist(Sun.position)))
        love.graphics.draw(info, 10, i * 20)
        finalPos = i * 20
    end

    finalPos = finalPos + 20

    if Player.fuel > 0 then
        love.graphics.setColor(0.4, 1, 0.4)
    else
        love.graphics.setColor(1, 0.4, 0.4)
    end
    
    local info = love.graphics.newText(font, "Fuel Remaining: " .. Round(Player.fuel))
    love.graphics.draw(info, 10, finalPos)

    if Player.velocityLocked == true then
        finalPos = finalPos + 20
        love.graphics.setColor(1, 0.4, 0.4)
        local info = love.graphics.newText(font, "Attitude Assist Active")
        love.graphics.draw(info, 10, finalPos)
    end

    if Player.thrusting == true then
        finalPos = finalPos + 20
        love.graphics.setColor(1, 0.4, 0.4)
        local info = love.graphics.newText(font, "Thrusting")
        love.graphics.draw(info, 10, finalPos)
    end

end
