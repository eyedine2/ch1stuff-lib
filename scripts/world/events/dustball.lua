---@class dustball : Event
---
---
---@overload fun(...) : dustball
local dustball, super = Class(Event)

function dustball:init(data)
    super.init(self, data.x, data.y, 5, 5)
    properties = data.properties or {}
    self:setOrigin(0.5, 0.5)
	self.solid = false
    self.dustball = Assets.getFramesOrTexture("npcs/dw/dustball")
    self.dustball_index = 1
    self.mytime = 0
    self.myindex = 1
end

function dustball:draw()
    super.draw(self)
    Draw.draw(self.dustball[self.myindex], math.sin(self.mytime / 5), math.cos(self.mytime / 3.5), 0, 2, 2)
end

function dustball:update()
    super.update(self)
    self.mytime = self.mytime + (1 * DTMULT)
    if self.mytime >= 55 then
        self.remove(self)
    end
    self.x = self.x + 1.6 * DTMULT
    self.y = self.y - 0.8 * DTMULT
    self.myindex = Utils.clamp(Utils.ceil(self.mytime / 13), 1, 4)
end

function dustball:onInteract(chara, dir)
    return true
end

return dustball