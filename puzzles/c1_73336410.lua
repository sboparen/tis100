function get_name()
    return "SIGNAL SPLICER"
    -- by Simon Parent
end

function get_description()
    return {
        "READ A VALUE FROM IN.A",
        "WRITE THE ABSOLUTE VALUE TO OUT",
        "CONTINUE UNTIL IN.A IS EXHAUSTED",
        "READ A VALUE FROM IN.B",
        "WRITE THE ABSOLUTE VALUE TO OUT",
    }
end

function get_streams()
    input = {}
    input2 = {}
    output = {}
    an = math.random(9,29)
    bn = 39 - an
    for i = 1,an do
        input[i] = math.random(-99, 99)
        output[i] = math.abs(input[i])
    end
    for i = 1,bn do
        input2[i] = math.random(-99, 99)
        output[i+an] = math.abs(input2[i])
    end
    return {
        { STREAM_INPUT, "IN.A", 1, input },
        { STREAM_INPUT, "IN.B", 2, input2 },
        { STREAM_OUTPUT, "OUT", 2, output },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_MEMORY,  TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_MEMORY,
    }
end
