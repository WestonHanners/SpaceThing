local vector = require "../vendor/vector"

local SCALE = 4.0
local ORIGIN = { x = 500, y = 500 }

Earth = {
    name = "Earth",
    position = vector(ORIGIN.x, ORIGIN.y - 5000),
    velocity = vector(150, 0),
    mass = 150.0 * SCALE,
    size = 8 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(BlueColor)
        love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

SmallPlanet = {
    name = "Mercury",
    position = vector(ORIGIN.x, ORIGIN.y - 1000),
    velocity = vector(250, 0),
    mass = 0.25 * SCALE,
    size = 5 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(RedColor)
        love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Moon = {
    name = "Moon",
    position = vector(ORIGIN.x - 5000, ORIGIN.y - 5100),
    velocity = vector(155, 0),
    mass = 0.0015 * SCALE,
    size = 2 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(GrayColor)
        love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Sun = {
    name = "Sun",
    position = vector(ORIGIN.x, ORIGIN.y) * SCALE,
    velocity = vector(0, 0) * SCALE,
    mass = 10000.0 * SCALE,
    size = 30 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(YellowColor)
        love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

LargePlanet = {
    name = "Jupiter",
    position = vector(ORIGIN.x, ORIGIN.y - 10000) * SCALE,
    velocity = vector(48, 0) * SCALE,
    mass = 600 * SCALE,
    size = 15 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(GreenColor)
        love.graphics.circle("fill", self.position.x, self.position.y, self.size)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}