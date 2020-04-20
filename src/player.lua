local vector = require "../vendor/vector"

Player = {
    name = "Player",
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