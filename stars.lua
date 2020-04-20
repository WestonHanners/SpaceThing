Stars = {}

function LoadStars()
    math.randomseed = 1
    for x = 0, 1920 do
        for y = 0, 1080 do
            if love.math.noise(x, y) - math.random() > .97 then
                Stars[#Stars+1] = x + 0.5
                Stars[#Stars+1] = y + 0.5
            end
        end
    end
end

function DrawStars()
    love.graphics.setColor(1, 1, 1)
    love.graphics.points(Stars)
end
