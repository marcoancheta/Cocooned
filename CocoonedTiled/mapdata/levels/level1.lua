return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 22,
  height = 22,
  tilewidth = 32,
  tileheight = 32,
  properties = {
    ["finishLocation"] = "!json! {\"x\" : 12, \"y\" : 12}",
    ["playerLocation"] = "!json! {\"x\" : 2, \"y\" : 2}"
  },
  tilesets = {
    {
      name = "tileset_bob",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../../../Ceramic-Tile-Engine-master/mapdata/tileset_bob.png",
      imagewidth = 288,
      imageheight = 64,
      properties = {},
      tiles = {
        {
          id = 4,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 5,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 6,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 7,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 8,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 13,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 14,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 15,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        },
        {
          id = 16,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "tiles",
      x = 0,
      y = 0,
      width = 22,
      height = 22,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
        9, 1, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 2, 9,
        9, 10, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 9, 9, 6, 18, 18, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 9, 9, 9, 18, 18, 9,
        9, 1, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 2, 9, 9, 18, 18, 9,
        9, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 5, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 6, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 9, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 1, 18, 18, 18, 18, 18, 18, 2, 9, 9, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 18, 18, 18, 18, 18, 18, 9, 9, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 5, 18, 9, 6, 18, 18, 9, 9, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 9, 18, 18, 9, 18, 18, 9, 9, 18, 18, 18, 18, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 9, 18, 18, 9, 18, 18, 18, 18, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 18, 18, 18, 18, 14, 9, 9, 15, 18, 18, 14, 15, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 11, 9, 9, 18, 18, 9,
        9, 18, 18, 9, 9, 18, 18, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 9, 9, 18, 18, 9,
        9, 18, 18, 14, 9, 18, 18, 9, 9, 9, 18, 18, 9, 9, 9, 9, 9, 9, 15, 18, 18, 9,
        9, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 9,
        9, 10, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 11, 9,
        9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
      }
    }
  }
}
