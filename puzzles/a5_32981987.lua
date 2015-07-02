function get_name()
    return "POLARIZING ENTANGLEMENT"
    -- by Simon Parent
end

function get_description()
    return {
        "EACH INPUT HAS EXACTLY 39 VALUES",
        "READ A VALUE FROM IN.A AND WRITE THE VALUE TO OUT.Z IF IN.A > 0",
        "READ A VALUE FROM IN.B AND WRITE THE VALUE TO OUT.Y IF IN.B < 0",
        "DISCARD UNUSED VALUES",
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
        if math.random(0, 99) < 40 then
            input1[i] = -input1[i]
        end
        if math.random(0, 99) < 60 then
            input2[i] = -input2[i]
        end
        if input1[i] > 0 then
            table.insert(output2, input1[i])
        end
        if input2[i] < 0 then
            table.insert(output1, input2[i])
        end
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
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_MEMORY,  TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE,
    }
end
