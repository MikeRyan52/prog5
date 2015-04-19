local composer = require 'composer'
local scene = composer.newScene()

local levelData, playLevel, playLevelBtn, bricks

bricks = {}

levelData = {
	{ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
	{ -1,  0,  0,  0,  0,  0,  0,  0,  0, -1},
	{ -1,  0,  1,  1,  1,  1,  1,  1,  0, -1},
	{ -1,  0,  2,  2,  1,  1,  2,  2,  0, -1},
	{ -1,  0,  1,  1,  1,  1,  1,  1,  0, -1},
	{ -1,  0,  1,  3,  2,  2,  3,  1,  0, -1},
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
end

function scene:show(event)
	
end

function scene:hide(event)

end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene