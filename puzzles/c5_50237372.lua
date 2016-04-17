function get_name()
    return "EVERETT CALIBRATOR"
    -- by Simon Parent
end

function get_description()
    return {
        "READ A VALUE FROM IN.X AND WRITE THE VALUE TO OUT.Y",
        "READ A VALUE FROM IN.Y AND WRITE THE VALUE TO OUT.X",
        "TESTS 1 THROUGH 3 ARE THE SAME",
    }
end

function get_streams()
    input1 = {}
    input2 = {}
    for i = 1,42 do
        discard = math.random(10, 30)
    end
    a = math.random(10, 30)
    for i = 1,113 do
        discard = math.random(10, 30)
    end
    b = math.random(10, 30)
    for i = 1,39 do
        input1[i] = (i > a) and 1 or 0
        input2[i] = (i > b) and 1 or 0
    end
    return {
        { STREAM_INPUT, "IN.X", 0, input1 },
        { STREAM_INPUT, "IN.Y", 3, input2 },
        { STREAM_OUTPUT, "OUT.X", 0, input2 },
        { STREAM_OUTPUT, "OUT.Y", 3, input1 },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE,
    }
end
