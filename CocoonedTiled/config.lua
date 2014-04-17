--calculate the aspect ratio of the device
local aspectRatio = display.pixelHeight / display.pixelWidth
application = {
   content = {
      width = aspectRatio > 1.5 and 820 or math.ceil( 1200 / aspectRatio ),
      height = aspectRatio < 1.5 and 1400 or math.ceil( 800 * aspectRatio ),
      scale = "letterBox",
      fps = 60,

      imageSuffix = {
         ["@2x"] = 1.3,
      },
   },
}