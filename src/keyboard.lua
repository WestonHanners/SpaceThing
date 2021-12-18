require "src/layers"

function ProcessInput(key)
    if key == "c" then
        if Config.CameraIndex + 1 > #Bodies then
            Config.CameraIndex = 1
        else
            Config.CameraIndex = Config.CameraIndex + 1
        end
    end
    
    if key == "w" then
        Config.ZoomFactor = Config.ZoomFactor * 0.8
    elseif key == "s" then
        Config.ZoomFactor = Config.ZoomFactor / 0.8
    end
    
    if key == "a" then
        Player.velocityLocked = not Player.velocityLocked
    end
    
    if key == "p" then
        Config.PAUSE = not Config.PAUSE
    end
    
    if key == "d" then
        Config.DISPLAY = not Config.DISPLAY
    end
    
    if key == "q" then
        love.event.quit(0)
    end
    
    if key == "space" then
        Config.STEP = true
    end
    
    if key == "o" then
        Config.FRAMEADVANCE = not Config.FRAMEADVANCE
    end

end

function ProcessContinuousInput(dt, layers)
    if love.keyboard.isDown("left") then
        Player:rotateLeft(dt)
    elseif love.keyboard.isDown("right") then
        Player:rotateRight(dt)
    end

    if love.keyboard.isDown("down") then
        Player.thrusting = true
        Player:thrustReverse(dt)
    elseif love.keyboard.isDown("up") then
        Player.thrusting = true
        Player:thrustForward(dt)
    else
        Player.thrusting = false
    end
end