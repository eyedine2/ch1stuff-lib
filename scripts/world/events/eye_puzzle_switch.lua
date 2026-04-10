---@class eye_puzzle_switch : Event
---
---@field shine             love.Image
---@field marking             love.Image
---@field behavior      table  *[Property `behavior`]* What this switch object does in relation to its other siblings
---@field myid      integer  *[Property `myid`]* old
---@overload fun(...) : eye_puzzle_switch
local eye_puzzle_switch, super = Class(Event)

function eye_puzzle_switch:init(data)
    super.init(self, data.x, data.y, data.width,data.height)
    properties = data.properties or {}
    self.myid = properties["myid"] or 1
    self.width = 40
    self.height = 160
    self:setOrigin(0, 0)
    self.sprite = Sprite("puzzle/darkeye")
    self.sprite.x = -18
	self:addChild(self.sprite)
    self.sprite.scale_x = 1
    self.sprite.scale_y = 1
	self.solid = true
    self.shin = Sprite("world/shine",9,135,2,2)
    self.shin:setScale(2)
    self.shin:play(1/5, true)
    self.marking = Assets.getFramesOrTexture("puzzle/eye_hint")
    self.behavior = properties["behavior"] or {1,1,0}
    self:addChild(self.shin)


end
function eye_puzzle_switch:draw()
    super.draw(self)

    for i = 1, #self.behavior do
        Draw.draw(self.marking[self.behavior[i] + 1], 12 * (i - 1), 80, 0, 2, 2)
    end
end

function eye_puzzle_switch:update()

    if self.myparent.sol[self.myid] == 1 then
        self.sprite:setFrame(2)
    else
        self.sprite:setFrame(1)
    end

    if self.myparent:getFlag("solved_eyepuzzle", false) == true then 
        self:removeChild(self.shin)
        self.sprite:setFrame(2)
    end

    super.update(self)
end

function eye_puzzle_switch:onInteract(player, dir)
    super.onInteract(self, player, dir)
    if self.myparent:getFlag("solved_eyepuzzle", false) == false then
        Assets.playSound("noise")
        self.myparent:myEventNew(self.behavior)
    end
end

function eye_puzzle_switch:postLoad()
    self.myparent = Game.world:getEvent("eye_puzzle")
end

return eye_puzzle_switch