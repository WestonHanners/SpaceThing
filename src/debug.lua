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

    if Player.velocityLocked == true then
        love.graphics.setColor(1, 0.4, 0.4)
        local info = love.graphics.newText(font, "Attitude Assist Active")
        love.graphics.draw(info, 10, finalPos + 20)
    end
end
