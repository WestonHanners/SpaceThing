require "src/colors"

local fontSize = 15
local lineSpacing = 20
local leftMargin = 10
local font = love.graphics.newFont("fonts/Hack-Bold.ttf", fontSize)

function DrawLine(text, color, top)
    love.graphics.setColor(color)
    love.graphics.draw(text, leftMargin, top)
    return top + lineSpacing
end

function DrawAlert(text, color)
    love.graphics.setColor(color)
    alert = love.graphics.newText(font, text)

    left = love.graphics.getWidth() * 0.5 - alert:getWidth() * 0.5
    top = love.graphics.getHeight() * 0.5 + alert:getHeight() -- Display below the player sprite.

    love.graphics.draw(alert, left, top) 
end

function DrawInfo(Bodies)
    local textColor = WhiteColor
    local nextLine = lineSpacing

    for i = 1, #Bodies do
        local body = Bodies[i]
        local info = love.graphics.newText(font, body.name .. ": " .. Round(body.position:dist(Sun.position)))
        nextLine = DrawLine(info, textColor, nextLine)
    end

    -- Fuel Message
    local fuelColor = GreenColor

    if Player.fuel <= 0 then
        fuelColor = RedColor
    end
    
    local fuel = love.graphics.newText(font, "Fuel Remaining: " .. Round(Player.fuel))
    nextLine = DrawLine(fuel, fuelColor, nextLine)

    -- V Lock Message
    if Player.velocityLocked == true then
        local vlockMessageColor = RedColor
        local vlockMessage = love.graphics.newText(font, "Attitude Assist Active")
        nextLine = DrawLine(vlockMessage, vlockMessageColor, nextLine)
    end

    -- Thrusting Message 
    if Player.thrusting == true then
        local thrust = love.graphics.newText(font, "Thrusting")
        nextLine = DrawLine(thrust, RedColor, nextLine)
    end

    -- Frame Advance Message
    if Config.FRAMEADVANCE == true then
        local frameAdvanceMessage = love.graphics.newText(font, "Frame Advance Active")
        nextLine = DrawLine(frameAdvanceMessage, BlueColor, nextLine)
    end

end
