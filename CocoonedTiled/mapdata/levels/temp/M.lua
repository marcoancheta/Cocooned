return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 20,
  height = 12,
  tilewidth = 72,
  tileheight = 72,
  properties = {
    ["playerLocation"] = "!json! {\"x\":10, \"y\":6}"
  },
  tilesets = {
    {
      name = "black tile",
      firstgid = 1,
      tilewidth = 72,
      tileheight = 72,
      spacing = 0,
      margin = 0,
      image = "../../art/black tile.png",
      imagewidth = 72,
      imageheight = 72,
      properties = {},
      tiles = {
        {
          id = 0,
          properties = {
            ["bodyType"] = "static",
            ["physics:bounce"] = "0",
            ["physics:enabled"] = "true"
          }
        }
      }
    },
    {
      name = "white tile",
      firstgid = 2,
      tilewidth = 72,
      tileheight = 72,
      spacing = 0,
      margin = 0,
      image = "../../art/white tile.png",
      imagewidth = 72,
      imageheight = 72,
      properties = {},
      tiles = {}
    },
    {
      name = "blue aura sphere 1",
      firstgid = 3,
      tilewidth = 72,
      tileheight = 72,
      spacing = 0,
      margin = 0,
      image = "../../art/blue aura sphere 1.png",
      imagewidth = 72,
      imageheight = 72,
      properties = {},
      tiles = {
        {
          id = 0,
          properties = {
            ["bodyType"] = "static",
            ["name"] = "blueAura",
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
      width = 20,
      height = 12,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    }
  }
}
