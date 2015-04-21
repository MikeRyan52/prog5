local composer = require 'composer'
local findSpace = require 'utilities.find-space'
local json = require 'json'

local space = findSpace(300, 400)

if space then
	print(json.encode(space))
end

composer.gotoScene( 'views.level-creator', {
	effect = "fade",
	time = 200
})