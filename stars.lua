Stars = {}

function LoadStars()
    math.randomseed = 1
    for x = -5000, 5000 do
        for y = -5000, 5000 do
            if love.math.noise(x, y) - math.random() > .975 then
                Stars[#Stars+1] = x
                Stars[#Stars+1] = y
            end
        end
    end
end

function DrawStars()
    love.graphics.setColor(1, 1, 1)
    love.graphics.points(Stars)
end
