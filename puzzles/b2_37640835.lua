function get_name()
    return "SIGNAL ARITHMETIZER"
    -- by Simon Parent
end

function get_description()
    return {
        "WRITE IN.A + IN.B WHEN IN.S = 0",
        "WRITE IN.A - IN.B WHEN IN.S = 1",
        "WRITE IN.A * IN.B WHEN IN.S = 2",
        "OTHERWISE DIVIDE IN.A BY IN.B",
        "WRITE THE QUOTIENT WHEN IN.S = 3",
        "WRITE THE REMAINDER WHEN IN.S = 4",
    }
end

function get_streams()
    input0 = {}
    input1 = {}
    input2 = {}
    output = {}
    for i = 1,39 do
        input0[i] = math.random(0, 4)
        if input0[i] == 0 then
            input1[i] = math.random(0, 99)
            input2[i] = math.random(0, 99)
            output[i] = input1[i] + input2[i]
        elseif input0[i] == 1 then
            input1[i] = math.random(0, 99)
            input2[i] = math.random(0, 99)
            output[i] = input1[i] - input2[i]
        elseif input0[i] == 2 then
            input1[i] = math.random(0, 19)
            input2[i] = math.random(0, 19)
            output[i] = input1[i] * input2[i]
        elseif input0[i] == 3 then
            input1[i] = math.random(0, 99)
            input2[i] = math.random(1, 9)
            output[i] = math.floor(input1[i] / input2[i])
        elseif input0[i] == 4 then
            input1[i] = math.random(0, 99)
            input2[i] = math.random(1, 9)
            output[i] = input1[i] % input2[i]
        end
    end
    return {
        { STREAM_INPUT, "IN.A", 0, input1 },
        { STREAM_INPUT, "IN.S", 1, input0 },
        { STREAM_INPUT, "IN.B", 2, input2 },
        { STREAM_OUTPUT, "OUT", 2, output },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    }
end
