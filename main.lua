local push = require "push"
local vector = require "vector"
require "physics"
require "planets"
require "stars"

local gameWidth, gameHeight = 400, 400 --fixed game resolution
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
        love.graphics.push()
        love.graphics.setDefaultFilter('nearest', 'nearest')

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.image, self.position.x, self.position.y, self.direction, 1, 1, 31 * 0.5, 31 * 0.5)

        if DEBUG == true then
            local drawVector = (self.position + self.velocity)
            love.graphics.setColor(1,0,0)
            love.graphics.line(self.position.x, self.position.y, drawVector.x + 10, drawVector.y + 10)
        end

        love.graphics.pop()
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

    LoadStars()
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
        pixelperfect = true,
        fullscreen = false,
        stretched = true,
        vsync = true,
        resizable = true
    })
end

function love.draw()

    push:start()
    love.graphics.push()

    LockCamera(Bodies[CameraIndex])

    DrawStars()
    for i = 1, #Bodies do
        local body = Bodies[i]
        body:draw()
    end

    love.graphics.pop()

    push:finish()

end

function LockCamera(Body)

    love.graphics.scale(1 / ZoomFactor, 1 / ZoomFactor)

    love.graphics.translate(-Body.position.x + (gameWidth * 0.5) * ZoomFactor,
                            -Body.position.y + (gameHeight * 0.5) * ZoomFactor)

end

function love.update(dt)

    if pause == true then
        return
    end

    ProcessKeyboard(dt)
    -- ProcessCollision(dt)

    for i = 1, #Bodies do
        local body = Bodies[i]
        CalculateOrbitFor(body, Bodies, dt)
    end

    for i = 1, #Bodies do
        local body = Bodies[i]
        body:update(dt)
    end

end

function ProcessCollision(dt)
    if Player.position.x >= gameWidth - 10 then
        Player.velocity.x = -Player.velocity.x
    end

    if Player.position.x <= 0 + 10 then
        Player.velocity.x = -Player.velocity.x
    end

    if Player.position.y >= gameHeight - 10 then
        Player.velocity.y = -Player.velocity.y
    end

    if Player.position.y <= 0 + 10 then
        Player.velocity.y = -Player.velocity.y
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
        ZoomFactor = ZoomFactor + .1
    elseif key == "s" then
        ZoomFactor = ZoomFactor - .1
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

