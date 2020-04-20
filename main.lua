require "src/physics"
require "src/planets"
require "src/stars"
require "src/camera"
require "src/player"
require "src/debug"

local push = require "vendor/push"
local vector = require "vendor/vector"
local config = require "config"

local ZoomFactor = 1
local CameraIndex = 1

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

    LockCamera(Bodies[CameraIndex])

    Camera:draw()

    if DEBUG == true then
        DrawInfo(Bodies)
    end

    push:finish()

end

function LockCamera(Body)

    Camera:setScale(1 / ZoomFactor, 1 / ZoomFactor)
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
        if CameraIndex + 1 > #Bodies then
            CameraIndex = 1
        else
            CameraIndex = CameraIndex + 1
        end
    end

    if key == "w" then
        ZoomFactor = ZoomFactor + 0.1
    elseif key == "s" then
        ZoomFactor = ZoomFactor - 0.1
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
        Player:rotateLeft(dt)
    elseif love.keyboard.isDown("right") then
        Player:rotateRight(dt)
    end

    if love.keyboard.isDown("down") then
        Player.thrusting = true
        Player:thrustReverse(dt)
    elseif love.keyboard.isDown("up") then
        Player.thrusting = true
        Player:thrustForward(dt)
    else
        Player.thrusting = false
    end

end