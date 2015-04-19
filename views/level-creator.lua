local composer = require 'composer'
local scene = composer.newScene()

local levelData = {
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

function scene:create(event)

end

function scene:show(event)
	composer.gotoScene('views.level', {
		params = {
			levelData = levelData
		}
	})
end

function scene:hide(event)

end

scene:addEventListener( 'create', scene )
scene:addEventListener( 'show', scene )
scene:addEventListener( 'hide', scene )

return scene