local push = require "vendor/push"
local vector = require "vendor/vector"
local config = require "config"

require "src/physics"
require "src/planets"
require "src/stars"
require "src/camera"
require "src/player"
require "src/debug"

local Bodies = {
    Player, Sun, Earth, SmallPlanet, Moon, LargePlanet
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Camera.width = config.gameWidth
    Camera.height = config.gameHeight

    love.window.setTitle(config.TITLE)

    push:setupScreen(config.gameWidth, 
                     config.gameHeight,
                     config.windowWidth, 
                     config.windowHeight, {
        pixelperfect = true,
        fullscreen = false,
        stretched = false,
        vsync = true,
        resizable = true
    })

    Camera:newLayer(1, function()
        for i = 1, #Bodies do
            local body = Bodies[i]
            body:draw()
        end
    end)

    LoadStars()

    Camera:newLayer(0.5, function()
        DrawStars()
    end)

end

function love.draw()

    push:start()
    LockCamera(Bodies[config.CameraIndex])
    Camera:draw()

    if DEBUG == true then
        DrawInfo(Bodies)
    end

    push:finish()

end

function LockCamera(Body)

    Camera:setScale(1 / config.ZoomFactor, 1 / config.ZoomFactor)
    Camera:setPosition(Body.position)

end

function love.update(dt)

    if PAUSE == true then
        return
    end

    ProcessKeyboard(dt)

    for i = 1, #Bodies do
        local body = Bodies[i]
        CalculateOrbitFor(body, Bodies, dt)
    end

    for i = 1, #Bodies do
        local body = Bodies[i]
        body:update(dt)
    end

end

function love.keypressed(key)

    if key == "c" then
        if config.CameraIndex + 1 > #Bodies then
            config.CameraIndex = 1
        else
            config.CameraIndex = config.CameraIndex + 1
        end
    end

    if key == "w" then
        config.ZoomFactor = config.ZoomFactor + 0.1
    elseif key == "s" then
        config.ZoomFactor = config.ZoomFactor - 0.1
    end

    if key == "a" then
        Player.velocityLocked = not Player.velocityLocked
    end

    if key == "p" then
        PAUSE = not PAUSE
    end

    if key == "d" then
        DEBUG = not DEBUG
    end

    if key == "escape" then
        love.event.quit(0)
    end
end

function ProcessKeyboard(dt)

    if love.keyboard.isDown("left") then
        Player.direction = (Player.direction - (math.rad(180) * dt))
    elseif love.keyboard.isDown("right") then
        Player.direction = (Player.direction + (math.rad(180) * dt))
    end

    if love.keyboard.isDown("down") then
        Player.velocity = Player.velocity + vector(0, config.Thrust):rotated(Player.direction)
    elseif love.keyboard.isDown("up") then
        Player.velocity = Player.velocity + vector(0, -config.Thrust):rotated(Player.direction)
    end

end