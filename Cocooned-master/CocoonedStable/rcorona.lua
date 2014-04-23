--[[
rCorona
created by Charles Wong
v1.4 10/12/2011
Fixed if object removed from stage will get error
Fixed if object is not visible still dispatch event
Fixed different screen size
]]
module(..., package.seeall)

local socket = require("socket")
local udpSocket = nil
local isShake = false
local focus = {}-- focused event targets
local touchTargets = {}
local oldMessage = ""
local e = {name="", id=0, phase="", time=0, x=0, xStart=0, y=0, yStart=0}
local msg = ""
local newx = 0
local newxStart = 0
local newy = 0
local newyStart = 0
local isShake = false
local dispatched = false
local udpMessage = ""
local messageType = "0"
local dw = display.contentWidth
local dh = display.contentHeight

local function shutdownSocket()
	udpSocket:close()
	udpSocket = nil
	timer.cancel(tick)
end

local function decodeMessage(str)
	local pos, t = 1, {}
	for s, e in function() return string.find(str, ",", pos) end do
		table.insert(t, (string.gsub(string.sub(str, pos, s-1), "^%s*(.-)%s*$", "%1")))
		pos = e+1
	end
	table.insert(t, (string.gsub(string.sub(str, pos), "^%s*(.-)%s*$", "%1")))
	return t
end

function registerTouch(target)
	touchTargets[#touchTargets + 1] = target
end

-- by cmote modified by rCorona
local function touchEvent(tphase, tid, tx, ty, txStart, tyStart)
	dispatched = false
	e = {name="touch", id=tid, phase=tphase, time=system.getTimer(), x=tx, xStart=txStart, y=ty, yStart=tyStart}
	if focus[e.id] then
		local tgt = focus[e.id]
		e.target=tgt
		local status,ret = pcall(function () return tgt:dispatchEvent(e) end)
		if status and ret then
			if e.phase == "ended" then
				focus[e.id] = nil
			end
			return true
		end
		focus[e.id] = nil
	end

	for i=1, #touchTargets do
		local o = touchTargets[i]
		if o ~= nil and o.contentBounds ~= nil then
			if tx > o.contentBounds.xMin and tx < o.contentBounds.xMax and ty > o.contentBounds.yMin and ty < o.contentBounds.yMax and o.isVisible then
				e.target=o
				if o:dispatchEvent(e) then
					dispatched = true
					if e.phase == "began" then
						focus[e.id] = o
					end
					break
				end
			end
		else
			table.remove(touchTargets, i) -- if object is removed
		end
	end

	if not dispatched then
		e.target = nil
		Runtime:dispatchEvent(e)
	end
end

local function receiveMessage(event)
	-- Get Message
	if udpSocket ~= nil then
		udpMessage = udpSocket:receive()
		if udpMessage ~= nil and udpMessage ~= oldMessage then
			msg = decodeMessage(udpMessage)
			messageType = msg[1]
			isShake = false
			if messageType == "0" then
				if msg[8] == "1" then
					isShake = true
				end
				Runtime:dispatchEvent( { name = "accelerometer", xGravity = tonumber(msg[2]), yGravity = tonumber(msg[3]), zGravity = tonumber(msg[4]), xInstant = tonumber(msg[5]), yInstant = tonumber(msg[6]), zInstant = tonumber(msg[7]), isShake = isShake} )
				newx = (msg[11] / msg[15]) * dw
				newxStart = (msg[12] / msg[15]) * dw
				newy = (msg[13] / msg[16]) * dh
				newyStart = (msg[14] / msg[16]) * dh
				touchEvent(msg[9], msg[10], newx, newxStart, newy, newyStart)
			elseif messageType == "1" then
				if msg[8] == "1" then
					isShake = true
				end
				Runtime:dispatchEvent( { name = "accelerometer", xGravity = tonumber(msg[2]), yGravity = tonumber(msg[3]), zGravity = tonumber(msg[4]), xInstant = tonumber(msg[5]), yInstant = tonumber(msg[6]), zInstant = tonumber(msg[7]), isShake = isShake} )
				width = msg[9]
				height = msg[10]
			elseif messageType == "2" then
				newx = (msg[4] / msg[8]) * dw
				newxStart = (msg[5] / msg[8]) * dw
				newy = (msg[6] / msg[9]) * dh
				newyStart = (msg[7] / msg[9]) * dh
				touchEvent(msg[2], msg[3], newx, newxStart, newy, newyStart)
			end
			oldMessage = udpMessage
		end
	else
		shutdownSocket()
	end
end

function startServer(port, speed)
	-- Set Port
	if system.getInfo("environment") == "simulator" then
		udpSocket = socket.udp()
		udpSocket:setsockname("*", port)
		udpSocket:settimeout(0)
		Runtime:addEventListener("enterFrame", receiveMessage)
	end
end