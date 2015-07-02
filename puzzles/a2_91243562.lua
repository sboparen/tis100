function get_name()
    return "SIMPLE ENTANGLEMENT"
    -- by Simon Parent
end

function get_description()
    return {
        "EACH INPUT HAS EXACTLY 39 VALUES",
        "READ VALUES FROM IN.A AND IN.B",
        "WRITE IN.A - IN.B TO OUT.Y",
        "WRITE IN.B - IN.A TO OUT.Z",
    }
end

function get_streams()
    input1 = {}
    input2 = {}
    output1 = {}
    output2 = {}
    for i = 1,39 do
        input1[i] = math.random(10, 99)
        input2[i] = math.random(10, 99)
        output1[i] = input1[i] - input2[i]
        output2[i] = input2[i] - input1[i]
    end
    return {
        { STREAM_INPUT, "IN.A", 0, input1 },
        { STREAM_INPUT, "IN.B", 3, input2 },
        { STREAM_OUTPUT, "OUT.Y", 0, output1 },
        { STREAM_OUTPUT, "OUT.Z", 3, output2 },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE,
    }
end
