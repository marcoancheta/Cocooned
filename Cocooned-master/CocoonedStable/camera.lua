local lib_camera = {}
 
--------------------------------------------------------------------------------
-- Localize
--------------------------------------------------------------------------------
local display_newGroup = display.newGroup
local display_remove = display.remove
local type = type
local table_insert = table.insert
local math_huge = math.huge
local math_nhuge = -math.huge
 
local clamp = function(v, l, h) return (v < l and l) or (v > h and h) or v end
 
--------------------------------------------------------------------------------
-- Create View
--------------------------------------------------------------------------------
lib_camera.createView = function(layerCount)
	------------------------------------------------------------------------------
	-- Create view, internal object, and layers
	------------------------------------------------------------------------------
	local view = display_newGroup()
	view.damping = 1
	view.snapWhenFocused = true -- Do we instantly snap to the object when :setFocus() is called?
	
	local isTracking
	
	local internal -- So we can access it from inside the declaration
	internal = {
		trackingLevel = 1,
		damping = 1,
		scaleBoundsToScreen = true,
		xScale = 1,
		yScale = 1,
		addX = display.contentCenterX,
		addY = display.contentCenterY,
		bounds = {
			xMin = math_nhuge,
			xMax = math_huge,
			yMin = math_nhuge,
			yMax = math_huge
		},
		trackFocus = true,
		focus = nil,
		viewX = 0,
		viewY = 0,
		getViewXY = function() if internal.focus then return internal.focus.x, internal.focus.y else return internal.viewX, internal.viewY end end,
		layer = {},
	}
	
	local layers = {}
	
	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	-- Internal Methods
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	
	
	------------------------------------------------------------------------------
	-- Process Viewpoint
	------------------------------------------------------------------------------
	internal.processViewpoint = function()
		if internal.damping ~= view.damping then internal.trackingLevel = 1 / view.damping internal.damping = view.damping end
		if internal.trackFocus then
			local x, y = internal.getViewXY()

			x = clamp(x, internal.bounds.xMin, internal.bounds.xMax)
			y = clamp(y, internal.bounds.yMin, internal.bounds.yMax)
			internal.viewX, internal.viewY = x, y
		end
	end
	
	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	-- Public Methods
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	
	
	------------------------------------------------------------------------------
	-- Append Layer
	------------------------------------------------------------------------------
	view.appendLayer = function()
		local layer = display_newGroup()
		view:insert(layer)
		layer:toBack()
		table_insert(layers, layer)
	
		layer._perspectiveIndex = #layers
		
		internal.layer[#layers] = {
			x = 0,
			y = 0,
			xOffset = 0,
			yOffset = 0
		}
	end
	
	------------------------------------------------------------------------------
	-- Add an Object to the Camera
	------------------------------------------------------------------------------
	function view:add(obj, l, isFocus)
		local l = l or 4
		layers[l]:insert(obj)
		obj._perspectiveLayer = l
		
		if isFocus then view:setFocus(obj) end
		-- Move an object to a layer
		function obj:toLayer(newLayer) if layer[newLayer] then layer[newLayer]:insert(obj) obj._perspectiveLayer = newLayer end end
		--Move an object back a layer
		function obj:back() if layer[obj._perspectiveLayer + 1] then layer[obj._perspectiveLayer + 1]:insert(obj) obj._perspectiveLayer = obj.layer + 1 end end
		--Moves an object forwards a layer
		function obj:forward() if layer[obj._perspectiveLayer - 1] then layer[obj._perspectiveLayer - 1]:insert(obj) obj._perspectiveLayer = obj.layer - 1 end end
		--Moves an object to the very front of the camera
		function obj:toCameraFront() layer[1]:insert(obj) obj._perspectiveLayer = 1 obj:toFront() end
		--Moves an object to the very back of the camera
		function obj:toCameraBack() layer[#layers]:insert(obj) obj._perspectiveLayer = #layers obj:toBack() end
	end
	
	------------------------------------------------------------------------------
	-- Main Tracking Function
	------------------------------------------------------------------------------
	function view:trackFocus()
		internal.processViewpoint()
		local viewX, viewY = internal.viewX, internal.viewY
		
 
		for i = 1, #layers do
			local addX, addY = internal.addX, internal.addY
			local layerX, layerY = internal.layer[i].x, internal.layer[i].y
 
			local diffX = (-viewX - layerX)
			local diffY = (-viewY - layerY)
			local incrX = diffX
			local incrY = diffY
			internal.layer[i].x = layerX + incrX
			internal.layer[i].y = layerY + incrY
			
			layers[i].x = (layers[i].x - (layers[i].x - (internal.layer[i].x + addX)) * internal.trackingLevel)
			layers[i].y = (layers[i].y - (layers[i].y - (internal.layer[i].y + addY)) * internal.trackingLevel)
		end
 
		view.scrollX, view.scrollY = layers[1].x, layers[1].y
	end
	
	------------------------------------------------------------------------------
	-- Miscellaneous Functions
	------------------------------------------------------------------------------
	-- Begin auto-tracking
	function view:track() if not isTracking then Runtime:addEventListener("enterFrame", view.trackFocus) isTracking = true end end
	-- Stop auto-tracking
	function view:cancel() if isTracking then Runtime:removeEventListener("enterFrame", view.trackFocus) isTracking = false end end
	-- Remove an object from the view
	function view:remove(obj) if obj and obj._perspectiveLayer then layers[obj._perspectiveLayer]:remove(obj) end end
	-- Set the view's focus
	function view:setFocus(obj) if obj then internal.focus = obj end if view.snapWhenFocused then view.snap() end end
	-- Snap the view to the focus point
	function view:snap() local t = internal.trackingLevel local d = internal.damping internal.trackingLevel = 1 internal.damping = view.damping view:trackFocus() internal.trackingLevel = t internal.damping = d end
	-- Destroy the view
	function view:destroy() view:cancel() for i = 1, #layers do for o = 1, layers[i].numChildren do layers[i]:remove(layers[i][o]) end end display_remove(view) view = nil return true end

	------------------------------------------------------------------------------
	-- Build Layers
	------------------------------------------------------------------------------
	for i = layerCount or 8, 1, -1 do view.appendLayer() end
	
	return view
end
 
return lib_camera