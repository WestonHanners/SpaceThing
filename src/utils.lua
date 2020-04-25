function Round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function Lesser(a, b) 
    if a < b then return a end
    return b
end

function Greater(a, b) 
    if a > b then return a end
    return b
end