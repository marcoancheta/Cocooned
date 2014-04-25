--calculate the aspect ratio of the device
local aspectRatio = display.pixelHeight / display.pixelWidth
application = {
   content = {
      width = 320,
      height = 480,
      scale = "letterBox",
      fps = 60,

      imageSuffix = {
         ["@2x"] = 1.3,
      },
   },
}