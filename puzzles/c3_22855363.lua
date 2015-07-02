function get_name()
    return "ATOM SPLITTER"
    -- by Simon Parent
end

function get_description()
    return {
        "INTEGER LITERALS ARE FORBIDDEN",
        "LABELS ARE ALSO FORBIDDEN",
    }
end

function get_streams()
    return {
        { STREAM_INPUT,  "IN", 1, {2} },
        { STREAM_OUTPUT, "OUT", 1, {1} },
    }
end

function get_layout()
    return {
        TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED,
        TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED,
        TILE_DAMAGED, TILE_COMPUTE, TILE_COMPUTE, TILE_DAMAGED,
    }
end
