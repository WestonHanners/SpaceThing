local push = require "push"
local vector = require "vector"

require "physics"
require "planets"
require "stars"
require "camera"

local gameWidth, gameHeight = 800, 800 --fixed game resolution
local windowWidth, windowHeight = 800, 800
local Thrust = 1
local Speed = 20
local CameraIndex = 1
local ZoomFactor = 1
local pause = false
local DEBUG = false

Player = {
    position = vector(300,300),
    velocity = vector(0, 0),
    mass = 0.0001,
    image = love.graphics.newImage("gfx/ship.png"),
    direction = 0,
    velocityLocked = false,

    draw = function(self)
        love.graphics.setDefaultFilter('nearest', 'nearest')

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.image, self.position.x, self.position.y, self.direction, 1, 1, 31 * 0.5, 31 * 0.5)

        if DEBUG == true then
            local drawVector = (self.position + self.velocity)
            love.graphics.setColor(1,0,0)
            love.graphics.line(self.position.x, self.position.y, drawVector.x + 10, drawVector.y + 10)
        end

    end,

    update = function(self, dt)

        -- Handle Reaction Wheels
        if self.velocityLocked == true then
            self.direction = self.position.angleTo(self.velocity) + math.rad(90)
        end

        self.position = self.position + self.velocity * dt
    end
}

local Bodies = {
    Player, Sun, Earth, SmallPlanet, Moon
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Camera.width = gameWidth
    Camera.height = gameHeight

    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
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
    push:finish()

end

function LockCamera(Body)

    Camera:setScale(1 / ZoomFactor, 1 / ZoomFactor)
    Camera:setPosition(Body.position)

end

function love.update(dt)

    if pause == true then
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
        pause = not pause
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
        Player.velocity = Player.velocity + vector(0, Thrust):rotated(Player.direction)
    elseif love.keyboard.isDown("up") then
        Player.velocity = Player.velocity + vector(0, -Thrust):rotated(Player.direction)
    end

end

