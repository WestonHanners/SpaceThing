require "src/display"
require "src/utils"
require "src/colors"

local NoiseScale = 0.05
local StarRate = 0.0003

local stars = {}

local maxY = 0
local minY = 0
local maxX = 0
local minX = 0

StarField = {
    draw = function(self, camera)

        local startX = -camera.x
        local endX = -camera.x + (camera.width * camera.scaleX)
        local startY = -camera.y
        local endY = -camera.y + (camera.height * camera.scaleY)

        if startX < minX or endX > maxX or startY < minY or endY > maxY then
            local iterations = 0
            for x = Round(Lesser(startX, minX)), Round(Greater(endX, maxX)), 1 do
                for y = Round(Lesser(startY, minY)), Round(Greater(endY, maxY)), 1 do
                    iterations = iterations + 1
                    if love.math.noise(x * NoiseScale, y * NoiseScale) < StarRate then
                        stars[#stars+1] = x
                        stars[#stars+1] = y
                    end
                end
            end
            print("Iterations " .. iterations)
        end

        love.graphics.setColor(WhiteColor)
        love.graphics.points(stars)

        -- Update Extents

        if startX < minX then
            minX = startX
        end

        if startY < minY then
            minY = startY
        end

        if endX > maxX then
            maxX = endX
        end

        if endY > maxY then
            maxY = endY
        end
    end
}