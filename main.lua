require "src/physics"
require "src/planets"
require "src/stars"
require "src/camera"
require "src/player"
require "src/display"
require "config"

local push = require "vendor/push"

local ZoomFactor = 1
local CameraIndex = 1

local Bodies = {
    Player, Sun, Earth, SmallPlanet, Moon, LargePlanet
}

local ForegroundLayer = {
    Player, Sun, Earth, SmallPlanet, Moon, LargePlanet
}

local BackgroundLayer = {
    StarField
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Camera.width = Config.gameWidth
    Camera.height = Config.gameHeight

    love.window.setTitle(Config.TITLE)

    push:setupScreen(Config.gameWidth, 
                     Config.gameHeight,
                     Config.windowWidth, 
                     Config.windowHeight, {
        pixelperfect = true,
        fullscreen = false,
        stretched = false,
        vsync = true,
        resizable = true
    })

    Camera:newLayer(1, function()
        for i = 1, #ForegroundLayer do
            local drawable = ForegroundLayer[i]
            drawable:draw(Camera)
        end
    end)

    Camera:newLayer(0.8, function()
        for i = 1, #BackgroundLayer do
            local drawable = BackgroundLayer[i]
            drawable:draw(Camera)
        end
    end)

end

function love.draw()

    push:start()

    LockCamera(Bodies[CameraIndex])

    Camera:draw()

    if Config.DISPLAY == true then
        DrawInfo(Bodies)
    end

    push:finish()

end

function LockCamera(Body)

    Camera:setScale(1 / ZoomFactor, 1 / ZoomFactor)
    Camera:setPosition(Body.position)

end

function love.update(dt)

    ProcessKeyboard(dt)

    if dt > 0.45 then
        return
    end

    if Config.PAUSE == true then
        return
    end

    if Config.FRAMEADVANCE == true and Config.STEP == false then
        return
    end
    Config.STEP = false

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
        ZoomFactor = ZoomFactor * 0.8
    elseif key == "s" then
        ZoomFactor = ZoomFactor / 0.8
    end

    if key == "a" then
        Player.velocityLocked = not Player.velocityLocked
    end

    if key == "p" then
        Config.PAUSE = not Config.PAUSE
    end

    if key == "d" then
        Config.DISPLAY = not Config.DISPLAY
    end

    if key == "q" then
        love.event.quit(0)
    end

    if key == "space" then
        Config.STEP = true
    end

    if key == "o" then
        Config.FRAMEADVANCE = not Config.FRAMEADVANCE
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