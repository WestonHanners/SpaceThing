local vector = require "vector"

Earth = {
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
    position = vector(500, 500),
    velocity = vector(0, 0),
    mass = 10000.0,
    draw = function(self)
        love.graphics.setColor(217/255, 224/255, 8/255)
        love.graphics.circle("fill", self.position.x, self.position.y, 20)
    end,
    update = function(self, dt)
        self.position = self.position + self.velocity * dt
    end
}