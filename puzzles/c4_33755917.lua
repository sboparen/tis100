function get_name()
    return "COLD READER"
    -- by Simon Parent
end

function get_description()
    return {
        "READ AN X VALUE FROM IN",
        "PLOT A WHITE POINT AT THAT X-COORDINATE ON THE LINE BELOW THE POINT PREVIOUSLY PLOTTED",
        "THE INPUT HAS EXACTLY 3 VALUES",
    }
end

function get_streams()
    image = {}
    for i = 1, 30 * 18 do
        image[i] = 0
    end
    input = {}
    for y = 0,2 do
        x = math.random(0, 29)
        image[1+x+y*30] = 3
        input[y+1] = x
    end
    return {
        { STREAM_INPUT, "IN", 0, input },
        { STREAM_IMAGE, "", 2, image },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_DAMAGED, TILE_COMPUTE, TILE_MEMORY,
        TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    }
end
