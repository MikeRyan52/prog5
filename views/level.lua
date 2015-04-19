local composer = require( "composer" )
local scene = composer.newScene()
local levelLoader = require 'components.level-loader'

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- Local variables and fucntions
local level, renderUI, bricksText, nextLevelText

-- "scene:create()"
function scene:create( event )
   local sceneGroup = self.view

   -- create the background
   local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
   background:setFillColor( 1, 0.98, 0.84 )

   -- create the top bar
   local topbar = display.newRect( sceneGroup, display.contentCenterX, 60, display.actualContentWidth, 120 )
   topbar:setFillColor( 0.06, 0.36, 0.39 )

   -- create and load the level
   level = levelLoader.new(sceneGroup, event.params.levelData, 'views.level-two')
   level:loadLevel()

   -- Begin rendering the UI
   renderUI = function(event)
      if bricksText then bricksText:removeSelf() end
      bricksText = display.newText({
         parent = sceneGroup,
         text = 'Bricks: ' .. level.normalBricks,
         width = ( display.actualContentWidth / 2 ) - 20,
         height = 80,
         x = ( display.actualContentWidth / 4 ) + 20,
         y = 90,
         font = native.systemFontBold,
         fontSize = 32,
         align = 'left'
      })
   end

   -- Render the UI on each frame
   Runtime:addEventListener( 'enterFrame', renderUI )

   -- Create a simple Next Level button
   nextLevelText = display.newText({
      parent = sceneGroup,
      text = 'Level Creator',
      width = ( display.actualContentWidth / 2 ) - 20,
      height = 80,
      x = display.actualContentWidth - ( display.actualContentWidth / 4 ) - 20,
      y = 90,
      font = native.systemFont,
      fontSize = 32,
      align = 'right'
   })
   nextLevelText:setFillColor( 1, 0.83, 0.31 )

   nextLevelText:addEventListener( 'tap', function()
      if level.loaded then level:endLevel() end
      composer.gotoScene( 'views.level-creator', {
         effect = "fade",
         time = 200
      })
   end)
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      if level.loaded then
         level:startLevel()
      end

   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      level:endLevel()
   end
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

---------------------------------------------------------------------------------

return scene