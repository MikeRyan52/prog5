local composer = require 'composer'
local scene = composer.newScene()
local levelLoader = require 'components.level-loader'
local brick = require("components.brick")
local level

local levelData, playLevel, playLevelBtn, bricks, selected

bricks = {}

levelData = {
	{ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1, -2, -2, -2, -2, -2, -2, -2, -2, -1}
}
local templevelData = {
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ 0,  0,  0,  0,  0,  0,  0,  0,  0, 0},
	{ -1, -2, -2, -2, -2, -2, -2, -2, -2, -1}
}

playLevel = function()
	composer.gotoScene('views.level', {
		params = {
			levelData = levelData
		}
	})
end

function scene:create(event)
	local sceneGroup = self.view;

	-- create the background
	local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
	background:setFillColor( 1, 0.98, 0.84 )

	local topbar = display.newRect( sceneGroup, display.contentCenterX, 60, display.actualContentWidth, 120 )
	topbar:setFillColor(0.02, 0.2, 0.22)

	playLevelBtn = display.newText({
		parent = sceneGroup,
		text = 'Play Level',
		width = (display.actualContentWidth / 2) - 20,
		height = 80,
		x = display.actualContentWidth - (display.actualContentWidth / 4) - 20,
		y = 90,
		font = native.systemFont,
		fontSize = 32,
		align = 'right'
	})
	playLevelBtn:setFillColor( 1, 0.83, 0.31 )

	playLevelBtn:addEventListener( 'tap', playLevel )

	local unit = display.actualContentWidth / 8
	local x = ( unit / 2 ) + 4
	local y = 76
	local height = 76
	local width = unit - 8

	bricks.red = display.newRect( sceneGroup, x, y, width, height )
	bricks.red:setFillColor( 0.74, 0.29, 0.2 )

	x = x + unit

	bricks.blue = display.newRect( sceneGroup, x, y, width, height )
	bricks.blue:setFillColor( 0.06, 0.36, 0.39 )

	x = x + unit

	bricks.yellow = display.newRect( sceneGroup, x, y, width, height )
	bricks.yellow:setFillColor( 1, 0.83, 0.31 )

	x = x + unit

	bricks.grey = display.newRect( sceneGroup, x, y, width, height )
	bricks.grey:setFillColor( 1, 1, 1, 0.4 )
	local function blockselectred()
		bricks.blue.strokeWidth = 0
		bricks.yellow.strokeWidth = 0
		bricks.grey.strokeWidth = 0
		bricks.red.stroke = { 0, 0.98, 0.84 }
		bricks.red.strokeWidth = 3
		selected = 1
		bricks.brickType = 1
		bricks.hitpoints = 1
	end
	local function blockselectblue()
		bricks.red.strokeWidth = 0
		bricks.yellow.strokeWidth = 0
		bricks.grey.strokeWidth = 0
		bricks.blue.stroke = { 0, 0.98, 0.84 }
		bricks.blue.strokeWidth = 3
		selected = 2
		bricks.brickType = 2
		bricks.hitpoints = 2
	end
	local function blockselectyellow()
		bricks.red.strokeWidth = 0
		bricks.blue.strokeWidth = 0
		bricks.grey.strokeWidth = 0
		bricks.yellow.stroke = { 0, 0.98, 0.84 }
		bricks.yellow.strokeWidth = 3
		selected = 3
		bricks.brickType = 'yellow'
	end
	local function blockselectgrey()
		bricks.red.strokeWidth = 0
		bricks.blue.strokeWidth = 0
		bricks.yellow.strokeWidth = 0
		bricks.grey.stroke = { 0, 0.98, 0.84 }
		bricks.grey.strokeWidth = 3
		selected = -1
		bricks.brickType = 'wall'
		bricks.hitpoints = 1
	end
	bricks.red:addEventListener( "tap", blockselectred)
	bricks.blue:addEventListener( "tap", blockselectblue)
	bricks.yellow:addEventListener( "tap", blockselectyellow)
	bricks.grey:addEventListener( "tap", blockselectgrey)
	local zone = display.newRect( display.contentCenterX, display.contentCenterY + 120, display.contentWidth, display.contentHeight)
    zone:setFillColor( 0,0,0, .1)
    local function zoneHandler(event)
		 	-- convert the tap position to 18x10 grid position
			 -- based on the board size
		local x, y = event.target:contentToLocal(event.x, event.y);
		print(x,y)
		local storagex = x
		local storagey = y
		x = x + 225; -- conversion
		y = y + 225; -- conversion
		x = math.ceil( x/75 );
		y = math.ceil( y/65 );
		print(x,y)
		if event.numTaps == 1 then
			if selected == 1 then
			--local newbrick = brick:new(x, y, 1, sceneGroup)
				levelData[y+6][x+2] = 1
				print(event.y)
				level = brick:new(x, y, 1, sceneGroup, levelData, 'views.level-creator')
	   			level:loadLevel() 
	   			level:renderBricks()
			elseif selected == 2 then
			--local newbrick = brick:new(x, y, 1, sceneGroup)
				levelData[y+6][x+2] = 2
				level = levelLoader.new(sceneGroup, levelData, 'views.level-creator')
	   			level:loadLevel() 
	   			level:renderBricks()
			elseif selected == 3 then
			--local newbrick = brick:new(x, y, 1, sceneGroup)

				levelData[y+6][x+1] = 3
				level = levelLoader.new(sceneGroup, levelData, 'views.level-creator')
	   			level:loadLevel() 
	   			level:renderBricks()
			else 
			--local newbrick = brick:new(x, y, 1, sceneGroup)
				levelData[y+6][x+2] = -1 
				level = levelLoader.new(sceneGroup, levelData, 'views.level-creator')
	   			level:loadLevel() 
	   			level:renderBricks()
			end
		elseif event.numTaps == 2 then
			levelData[y+6][x+2] = 0
			event.target:removeSelf( )

		end
		local function brickmovement()
			--local x, y = event.target.x, event.target.y
			  if event.phase == "began" then   
			    brick.markX = brick.shape.x 
			    brick.markY = brick.y
			  elseif event.phase == "moved" then   
			    local x = (event.x - event.xStart) + self.shape.markX   
			    local y = (event.y - event.yStart) + self.shape.markY 
				    if (x <= 20 + self.shape.width/2) then
				       brick.x = 20+brick.width/2;
				    elseif (x >= display.contentWidth-20-brick.width/2) then
				       brick.x = display.contentWidth-20-brick.width/2;
				    else
				       brick.x = x;    
				    end
				       brick.y = y;    
			  end
		end
		zone:addEventListener("touch", brickmovement)
	end
	zone:addEventListener("tap", zoneHandler);

end

function scene:show(event)
	
end

function scene:hide(event)

end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene