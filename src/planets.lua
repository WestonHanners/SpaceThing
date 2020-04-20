local vector = require "../vendor/vector"

Earth = {
    name = "Earth",
    position = vector(500, 50),
    velocity = vector(63.75, 0),
    mass = 150.0,
    draw = function(self)
        love.graphics.setColor(8/255, 52/255, 224/225)
        love.graphics.circle("fill", self.position.x, self.position.y, 8)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

SmallPlanet = {
    name = "Mercury",
    position = vector(500, 240),
    velocity = vector(58, 0),
    mass = 0.25,
    draw = function(self)
        love.graphics.setColor(255/255, 3/255, 8/255)
        love.graphics.circle("fill", self.position.x, self.position.y, 5)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Moon = {
    name = "Moon",
    position = vector(500, 64),
    velocity = vector(72, 0),
    mass = 0.0015,
    draw = function(self)
        love.graphics.setColor(40/255, 40/255, 40/255)
        love.graphics.circle("fill", self.position.x, self.position.y, 2)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

Sun = {
    name = "Sun",
    position = vector(500, 500),
    velocity = vector(0, 0),
    mass = 10000.0,
    draw = function(self)
        love.graphics.setColor(217/255, 224/255, 8/255)
        love.graphics.circle("fill", self.position.x, self.position.y, 30)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}

LargePlanet = {
    name = "Jupiter",
    position = vector(500, -1000),
    velocity = vector(48, 0),
    mass = 600,
    draw = function(self)
        love.graphics.setColor(2/255, 253/255, 2/255)
        love.graphics.circle("fill", self.position.x, self.position.y, 15)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}