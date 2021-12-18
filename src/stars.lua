require "src/display"
require "src/utils"
require "src/colors"

local NoiseScale = 0.05
local StarRate = 0.0003

local chunks = {}
local chunkSize = {
    x = 800,
    y = 600
}

StarField = {
    draw = function(self, camera)
        local currentChunk = self.chunkCoords(-camera.x + camera.width * camera.scaleX / 2, 
                                              -camera.y + camera.height * camera.scaleY / 2,
                                              chunkSize)
        local chunkX, chunkY

        love.graphics.setColor(WhiteColor)


        local chunkXRange = math.floor(camera.width * camera.scaleX / chunkSize.x)
        local chunkYRange = math.floor(camera.height * camera.scaleY / chunkSize.y)

        for chunkX = currentChunk.x - chunkXRange, currentChunk.x + chunkXRange do
            for chunkY = currentChunk.y - chunkYRange, currentChunk.y + chunkYRange do
                local chunkIndex = tostring(chunkX)..":"..tostring(chunkY) 
                local chunk = chunks[chunkIndex]
                if chunk ~= nil then
                    --print("Rendering chunk: "..chunkIndex)
                    love.graphics.points(chunk)
                else
                    print("Generating chunk: "..chunkIndex)
                    chunks[chunkIndex] = self.generateChunk(chunkX, chunkY, chunkSize)
                    love.graphics.points(chunks[chunkIndex])
                end
            end
        end
    end,

    chunkCoords = function(x, y, chunkSize)
        local chunkX = math.floor(x / chunkSize.x)
        local chunkY = math.floor(y / chunkSize.y)

        return { x = chunkX, 
                 y = chunkY }
    end,

    generateChunk = function(chunkX, chunkY, chunkSize)
        local chunk = {}
        local startX = chunkX * chunkSize.x
        local startY = chunkY * chunkSize.y

        local stopX = startX + chunkSize.x
        local stopY = startY + chunkSize.y

        local x, y

        for x = startX, stopX do
            for y = startY, stopY do
                if love.math.noise(x * NoiseScale, y * NoiseScale) < StarRate then
                    chunk[#chunk+1] = x
                    chunk[#chunk+1] = y
                end                
            end
        end

        return chunk
    end
}