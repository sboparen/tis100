function get_name()
    return "ENTANGLEMENT DIAGNOSTIC"
    -- by Simon Parent
end

function get_description()
    return {
        "EACH INPUT HAS EXACTLY 39 VALUES",
        "READ A VALUE FROM IN.A AND WRITE THE VALUE TO OUT.Z",
        "READ A VALUE FROM IN.B AND WRITE THE VALUE TO OUT.Y",
    }
end

function get_streams()
    input1 = {}
    input2 = {}
    for i = 1,39 do
        input1[i] = math.random(10, 99)
        input2[i] = math.random(10, 99)
    end
    return {
        { STREAM_INPUT, "IN.A", 0, input1 },
        { STREAM_INPUT, "IN.B", 3, input2 },
        { STREAM_OUTPUT, "OUT.Y", 0, input2 },
        { STREAM_OUTPUT, "OUT.Z", 3, input1 },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE, TILE_DAMAGED,
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
    }
end
