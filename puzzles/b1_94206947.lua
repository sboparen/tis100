function get_name()
    return "SIGNAL DE-AMPLIFIER"
    -- by Simon Parent
end

function get_description()
    return {
        "INPUT VALUES ARE ALWAYS EVEN",
        "READ A VALUE FROM IN.A",
        "HALVE THE VALUE",
        "WRITE THE VALUE TO OUT.A",
    }
end

function get_streams()
    input = {}
    output = {}
    for i = 1,39 do
        output[i] = math.random(10, 99)
        input[i] = output[i] * 2
    end
    return {
        { STREAM_INPUT, "IN.A", 1, input },
        { STREAM_OUTPUT, "OUT.A", 2, output },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    }
end
