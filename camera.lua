Camera = {}
Camera.x = 0
Camera.y = 0
Camera.scaleX = 1
Camera.scaleY = 1
Camera.rotation = 0

Camera.width = 800
Camera.height = 800

function Camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
    love.graphics.translate(self.x, self.y)
end

function Camera:unset()
    love.graphics.pop()
end

function Camera:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
end
  
function Camera:rotate(dr)
    self.rotation = self.rotation + dr
end
  
function Camera:scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
end
  
function Camera:setPosition(vector)
    self.x = -vector.x + (Camera.width * 0.5) * Camera.scaleX or self.x
    self.y = -vector.y + (Camera.height * 0.5) * Camera.scaleY or self.y
end

function Camera:setScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end