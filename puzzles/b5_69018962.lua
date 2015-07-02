function get_name()
    return "CIRCLE VIEWER"
    -- by Simon Parent
end

function get_description()
    return {
        "READ X AND Y VALUES FROM IN",
        "READ AN R-SQUARED VALUE FROM IN",
        "READ A COLOUR VALUE FROM IN",
        "COLOUR ALL POINTS WHOSE SQUARED EUCLIDEAN DISTANCE FROM THE GIVEN POINT IS LESS THAN R-SQUARED",
    }
end

function get_streams()
    image = {}
    for i = 1, 30 * 18 do
        image[i] = 0
    end
    input = {}
    cx = 0
    cy = 0
    for i = 0,5 do
        cx = (cx + math.random(10, 20)) % 30
        cy = (cy + math.random(10, 20)) % 18
        cr = math.random(10, 99)
        cc = math.random(1, 4)
        for x = 0,29 do
            for y = 0,17 do
                if (x - cx) * (x - cx) + (y - cy) * (y - cy) < cr then
                    image[1+x+y*30] = cc
                end
            end
        end
        input[i*4+1] = cx
        input[i*4+2] = cy
        input[i*4+3] = cr
        input[i*4+4] = cc
    end
    return {
        { STREAM_INPUT, "IN", 0, input },
        { STREAM_IMAGE, "", 3, image },
    }
end

function get_layout()
    return {
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
        TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE, TILE_COMPUTE,
    }
end
