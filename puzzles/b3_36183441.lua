function get_name()
    return "FULL SIGNAL MULTIPLIER"
    -- by Simon Parent
end

function get_description()
    return {
        "READ VALUES FROM IN.A AND IN.B",
        "MULTIPLY THE VALUES",
        "WRITE THE LOWER THREE DIGITS OF THE PRODUCT TO OUT.L",
        "WRITE THE UPPER DIGITS OF THE PRODUCT TO OUT.H",
    }
end

function get_streams()
    input1 = {}
    input2 = {}
    output1 = {}
    output2 = {}
    for i = 1,39 do
        input1[i] = math.random(100, 999)
        input2[i] = math.random(100, 999)
        output1[i] = math.floor((input1[i] * input2[i]) / 1000)
        output2[i] = (input1[i] * input2[i]) % 1000
    end
    return {
        { STREAM_INPUT, "IN.A", 1, input1 },
        { STREAM_INPUT, "IN.B", 2, input2 },
        { STREAM_OUTPUT, "OUT.H", 1, output1 },
        { STREAM_OUTPUT, "OUT.L", 2, output2 },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    }
end
