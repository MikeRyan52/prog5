local brickWidth = display.actualContentWidth / 10
local brickHeight = ( display.actualContentHeight - 120 ) / 16

-- Create a new display rectangle and decorate the object
local function new(x, y, brickType, displayGroup)
	local box = display.newRect( displayGroup, x, y, brickWidth, brickHeight, type )
	box.isBrick = true

	-- Set the brick type and hitpoints
	if brickType < 3 and brickType > 0 then
		box.brickType = 'normal'
		box.hitpoints = brickType

	elseif brickType == 3 then
		box.brickType = 'yellow'
		box.hitpoints = -1

	elseif brickType == -1 then
		box.brickType = 'wall'
		box.hitpoints = -1

	elseif brickType == -2 then
		box.brickType = 'pit'
		box.hitpoints = -1
	end

	-- Set the correct fill color and stroke on the brick
	function box:setColor()
		if self.brickType == 'yellow' then
			self:setFillColor( 1, 0.83, 0.31 )
			self.stroke = { 1, 0.98, 0.84 }
			self.strokeWidth = 2

		elseif self.brickType == 'wall' then
			self:setFillColor(.7,.7,.7)

		elseif self.brickType == 'pit' then
			self:setFillColor( 0, 0, 0 )

		elseif self.hitpoints == 2 then
			self:setFillColor( 0.06, 0.36, 0.39 )
			self.stroke = { 1, 0.98, 0.84 }
			self.strokeWidth = 2

		elseif self.hitpoints == 1 then
			self:setFillColor( 0.74, 0.29, 0.2 )
			self.stroke = { 1, 0.98, 0.84 }
			self.strokeWidth = 2

		end
	end

	-- Reduce the hit points and set the color
	function box:weaken()
		local destroyed = false

		if self.hitpoints >= 0 then
			self.hitpoints = self.hitpoints - 1
		end

		if self.hitpoints == 0 then
			self:removeSelf()
			destroyed = true
		else
			self:setColor()
		end

		return destroyed
	end

	-- Strengthen the box and set the color (not used at this time)
	function box:strengthen()
		if self.hitpoints >= 0 then
			self.hitpoints = self.hitpoints + 1
		end

		if self.hitpoints > 1 then self.hitpoints = 1 end

		self:setColor()
	end

	box:setColor();

	return box;
end

return {
	new = new,
	width = brickWidth,
	height = brickHeight
}