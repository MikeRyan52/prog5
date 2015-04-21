local json = require 'json'
local brick = require 'components.brick'
local composer = require 'composer'
local brick = require 'components.brick'

function new(group, levelData, nextScene)
	group.loaded = false
	group.started = false
	group.normalBricks = 0

	-- Load the level from the JSON file in the /levels/ folder
	function group:loadLevel()
		self.levelName = "User Level"
		self.brickLayout = levelData
		self.loaded = true
		return true
	end

	-- Handle ball collision with bricks
	function group:ballCollision(other)
		if other.brickType == 'normal' then
			local destroyed = other:weaken()

			if destroyed then self.normalBricks = self.normalBricks - 1 end

		elseif other.brickType == 'yellow' then
			for i, brick in pairs(self.bricks) do
				if brick.brickType == 'normal' then
					if brick.hitpoints == 2 then brick.hitpoints = 1
					elseif brick.hitpoints == 1 then brick.hitpoints = 2 end

					brick:setColor()
				end
			end

		elseif other.brickType == 'pit' then
			self:restartLevel()
		end

		if self.normalBricks == 0 then
			self:nextLevel()
		end
	end

	-- Create the ball and setup event listeners
	function group:createBall()
		local ball = display.newCircle( self, display.contentCenterX - 30, display.actualContentHeight - brick.height * 6, 20 )
		ball:setFillColor( 0.86, 0.62, 0.21 )
		physics.addBody(ball, 'dynamic', { bounce = 1, radius = 20 })
		ball:applyForce( 10, 25, ball.x, ball.y )

		local function ballCollision(event)
			if event.phase == 'began'  and event.other.isBrick then
				self:ballCollision(event.other)
			end
		end

		ball:addEventListener( 'collision', ballCollision )
		self.ball = ball
	end

	-- Iterate through the brick data and draw all bricks
	function group:renderBricks()
		local bricks = {}
		local x = 0
		local y = 0
		local normalBricks = 0

		function xCoord()
			return ( x * brick.width ) + ( brick.width * 0.5 )
		end

		function yCoord()
			return ( y * brick.height ) + ( brick.height * 0.5 ) + 120
		end

		for i,row in pairs(self.brickLayout) do
			for j,brickData in pairs(row) do
				if brickData ~= 0 then
					local brick = brick.new( xCoord(), yCoord(), brickData, self, x, y )
					if brick.brickType == 'normal' then normalBricks = normalBricks + 1 end
					brick.coords = { x = x, y = y }
					physics.addBody( brick, 'kinematic' )

					table.insert(bricks, brick)
				end

				x = x + 1
			end
			y = y + 1
			x = 0
		end

		self.normalBricks = normalBricks
		self.bricks = bricks
	end

	-- Create the paddle and setup event listeners
	function group:createPaddle()
		local paddle = display.newRect( self, display.contentCenterX, display.contentHeight - display.actualContentHeight / 16, brick.width * 3, brick.height * 0.6 )
		local paddleTrack = display.newRect( self, display.contentCenterX, display.contentCenterY + 60, display.actualContentWidth, display.actualContentHeight - 120 )
		paddle:setFillColor( 0, 0, 0, 0.4 )
		paddleTrack:setFillColor( 0.5, 0.5, 0.5, 0.01 )
		physics.addBody( paddle, 'kinematic' )

		local function move(event)
			if self.paddle then
				if event.phase == 'began' then
					self.moving = true
					self.paddle.markX = self.paddle.x or 0
				elseif event.phase == 'moved' and self.paddle.markX then 
					local x = (event.x - event.xStart) + self.paddle.markX
					self.paddle.x = x
				elseif event.phase == 'ended' then
					self.moving = false
				end
			end
		end

		paddleTrack:addEventListener( 'touch', move )
		self.paddle = paddle
		self.paddleTrack = paddleTrack
	end

	-- Restarts the level by tearing everything down and building it up again
	-- Inefficient and creates a usability issue with the paddle's touch event,
	-- but good enough
	function group:restartLevel()
		timer.performWithDelay( 5, function() 
			self:endLevel() 
			self:startLevel()
		end)
	end

	-- Transition to the next level
	function group:nextLevel()
		timer.performWithDelay( 5, function() 
			self:endLevel()
			composer.gotoScene( nextScene, {
				effect = "fade",
				time = 200
			})
		end)
	end

	-- Start the physics engine and render the pieces
	function group:startLevel()
		if self.loaded and not self.started then
			self.started = true

			physics.start()
			physics.setGravity(0,4);

			self:renderBricks()
			self:createBall()
			self:createPaddle()
		end
	end

	-- Stop the physics engine and destroy the level
	function group:endLevel()
		if self.loaded and self.started then
			physics.stop()
			self.started = false

			for i,brick in pairs(self.bricks) do
				if brick.removeSelf then brick:removeSelf() end
			end

			self.bricks = {}
			self.ball:removeSelf()
			self.ball = false
			self.paddle:removeSelf()
			self.paddle = false;
			self.paddleTrack:removeSelf();
			self.paddleTrack = 0;
		end
	end
	function group:brickRemoval()
		self:deleteBrick( )
	end

	return group
end

return {
	new = new
}