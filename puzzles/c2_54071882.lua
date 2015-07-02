function get_name()
    return "RETROGRADE AMPLIFIER"
    -- by Simon Parent
end

function get_description()
    return {
        "READ A VALUE FROM IN.A",
        "DOUBLE THE VALUE",
        "WRITE THE VALUE TO OUT.A",
    }
end

function get_streams()
    input = {}
    output = {}
    for i = 1,39 do
        input[i] = math.random(10, 99)
        output[i] = input[i] * 2
    end
    return {
        { STREAM_INPUT, "IN.A", 0, input },
        { STREAM_OUTPUT, "OUT.A", 3, output },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE,
        TILE_COMPUTE, TILE_MEMORY,  TILE_MEMORY,  TILE_MEMORY,
        TILE_COMPUTE, TILE_DAMAGED, TILE_DAMAGED, TILE_COMPUTE,
    }
end
