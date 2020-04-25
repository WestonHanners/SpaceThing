local vector = require "../vendor/vector"

local SCALE = 4.0
local ORIGIN = 500, 500

Earth = {
    name = "Earth",
    position = vector(ORIGIN, ORIGIN - 5000),
    velocity = vector(150, 0),
    mass = 150.0 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(BlueColor)
        love.graphics.circle("fill", self.position.x, self.position.y, 8 * SCALE)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

SmallPlanet = {
    name = "Mercury",
    position = vector(ORIGIN, ORIGIN - 1000),
    velocity = vector(250, 0),
    mass = 0.25 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(RedColor)
        love.graphics.circle("fill", self.position.x, self.position.y, 5 * SCALE)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Moon = {
    name = "Moon",
    position = vector(ORIGIN - 5000, ORIGIN - 5100),
    velocity = vector(155, 0),
    mass = 0.0015 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(GrayColor)
        love.graphics.circle("fill", self.position.x, self.position.y, 2 * SCALE)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Sun = {
    name = "Sun",
    position = vector(ORIGIN, ORIGIN) * SCALE,
    velocity = vector(0, 0) * SCALE,
    mass = 10000.0 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(YellowColor)
        love.graphics.circle("fill", self.position.x, self.position.y, 30 * SCALE)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

LargePlanet = {
    name = "Jupiter",
    position = vector(ORIGIN, ORIGIN - 10000) * SCALE,
    velocity = vector(48, 0) * SCALE,
    mass = 600 * SCALE,
    draw = function(self, camera)
        love.graphics.setColor(GreenColor)
        love.graphics.circle("fill", self.position.x, self.position.y, 15 * SCALE)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}