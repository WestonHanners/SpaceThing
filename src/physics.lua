local GravityConstant = 1.5
local Friction = 200

function CalculateOrbitFor(planet, otherBodies, dt)

    local function CalculateOrbitAgainst(otherBody)
        local distance = (otherBody.position - planet.position):len()
        local forceDirection = (otherBody.position - planet.position):normalized()
        local force = (forceDirection * GravityConstant * planet.mass * otherBody.mass) / distance
        local acceleration = force / planet.mass
        planet.velocity = planet.velocity + acceleration * dt
    end

    for i = 1, #otherBodies do
        local otherBody = otherBodies[i]
        if otherBody ~= planet then
            CalculateOrbitAgainst(otherBody)
        end
    end

end

function ApplyFriction(value, dt)

    if value == 0 then
        return 0
    end

    if value > 0 then
        return value - (Friction * dt)
    elseif value < 0 then
        return value + (Friction * dt)
    end
end