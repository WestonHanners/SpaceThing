require "../config"
require "src/game"

local vector = require "../vendor/vector"

local Thrust = 60
local StartingFuel = 500
local FuelRate = 2

local function spendFuel(dt)
    Player.fuel = Player.fuel - (FuelRate * dt)
end

Player = {
    name = "Player",
    position = vector(300,300),
    velocity = vector(0, 0),
    mass = 0.0001,
    image = love.graphics.newImage("gfx/ship.png"),
    direction = 0,
    velocityLocked = false,
    thrusting = false,
    fuel = StartingFuel,

    draw = function(self)
        love.graphics.setDefaultFilter('nearest', 'nearest')

        love.graphics.setColor(WhiteColor)
        love.graphics.draw(self.image, self.position.x, self.position.y, self.direction, 1, 1, 31 * 0.5, 31 * 0.5)

        if Config.DISPLAY == true then
            local drawVector = (self.position + self.velocity)
            love.graphics.setColor(RedColor)
            love.graphics.line(self.position.x, self.position.y, drawVector.x + 10, drawVector.y + 10)
        end

    end,

    update = function(self, dt)

        if self.position:dist(Sun.position) > Game.lostDistance then
            Game.reason = "Lost in space."
            Game.gameover = true
        end

        -- Handle Reaction Wheels
        if self.velocityLocked == true then
            self.direction = self.position.angleTo(self.velocity) + math.rad(90)
        end

        self.position = self.position + self.velocity * dt
    end,

    thrustForward = function(self, dt)
        if self.fuel <= 0 then
            return
        end
        spendFuel(dt)
        self.velocity = self.velocity + vector(0, -Thrust * dt):rotated(self.direction)
    end,

    thrustReverse = function(self, dt)
        if self.fuel <= 0 then
            return
        end
        spendFuel(dt)
        self.velocity = self.velocity + vector(0, Thrust * dt):rotated(self.direction)
    end,

    rotateLeft = function(self, dt)
        self.direction = (self.direction - (math.rad(180) * dt))
    end,

    rotateRight = function(self, dt)
        self.direction = (self.direction + (math.rad(180) * dt))
    end,
}