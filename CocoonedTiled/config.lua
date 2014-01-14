--calculate the aspect ratio of the device
local aspectRatio = display.pixelHeight / display.pixelWidth
application = {
   content = {
      width = 864,
      height = 1440,
      scale = "letterBox",
      fps = 60,

      imageSuffix = {
         ["@2x"] = 1.3,
      },
   },
}
