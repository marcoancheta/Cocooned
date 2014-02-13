--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cocooned by Damaged Panda Games (http://signup.cocoonedgame.com/)
-- bonus.lua
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local bonus = {}
local trees = {}

local W = display.contentWidth + 77
local H = display.contentHeight - 15

local bGroup = display.newGroup()

function bonus:init()
		
	local background = display.newRect(720, 430, W, H)
	
	trees = {
		[1] = {
			imgPath = "mapdata/art/tree.png",
			speed = 5000
		},
		[2] = {
			imgPath = "mapdata/art/tree2.png",
			speed = 5000
		},
		[3] = {
			imgPath = "mapdata/art/tree3.png",
			speed = 5000
		}
	}		  

end

function bonus:getRand()

	local temp = trees[math.random(1, #trees)]
	local randTree = display.newImage(temp.imgPath)
	
	print("getRand")
	
	--physics.addBody(randTree, "static", {bounce=0})
	randTree.name = "tree"
	randTree.speed = temp.speed
	randTree.x = W + 50
	randTree.y = math.random(0, H)
	randTree:rotate(-90)
	
	moveTree = transition.to(randTree, {time=randTree.speed, x=-500,
							 onComplete=function(self) self.parent:remove(self); self=nil; end})

end

function bonus:start()	
	treeTimer = timer.performWithDelay(1000, bonus.getRand, 0)
end

local function main()
	bonus:init()
	bonus:start()
end

bonus.main = main

return bonus