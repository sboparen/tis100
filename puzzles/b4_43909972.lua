function get_name()
    return "LONG SEQUENCE REVERSER"
    -- by Simon Parent
end

function get_description()
    return {
        "SEQUENCES ARE ZERO-TERMINATED",
        "READ A SEQUENCE FROM IN",
        "REVERSE THE SEQUENCE",
        "WRITE THE SEQUENCE TO OUT",
        "THE INPUT HAS ONLY ONE SEQUENCE",
    }
end

function get_streams()
    input = {}
    output = {}
    n = math.random(34, 38)
    for i = 1,n do
        input[i] = math.random(1, 9)
    end
    input[n+1] = 0
    for i = 1,n do
        output[i] = input[n+1-i]
    end
    output[n+1] = 0
    return {
        { STREAM_INPUT, "IN", 1, input },
        { STREAM_OUTPUT, "OUT", 3, output },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE, TILE_COMPUTE,
    }
end
