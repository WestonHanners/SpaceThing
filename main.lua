require "src/physics"
require "src/planets"
require "src/player"
require "src/stars"
require "src/camera"
require "src/display"
require "src/keyboard"
require "src/layers"
require "src/game"
require "config"

local push = require "vendor/push"

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

    Camera:lock(Bodies[Config.CameraIndex])

    Camera:draw()

    if Config.DISPLAY == true then
        DrawInfo(Bodies)
    end

    if Game.gameover == true then
        DrawAlert(Game.reason, RedColor)
        Config.PAUSE = true
    end

    push:finish()

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
    ProcessInput(key)
end

function ProcessKeyboard(dt)
    ProcessContinuousInput(dt)
end