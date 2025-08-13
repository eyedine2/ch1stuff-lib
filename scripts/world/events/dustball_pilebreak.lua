---@class dustball_pilebreak : Event
---
---
---@overload fun(...) : dustball_pilebreak
local dustball_pilebreak, super = Class(Event)

function dustball_pilebreak:init(data)
    super.init(self, data.x, data.y, 5, 5)
    properties = data.properties or {}
    self:setOrigin(0.5, 0.5)
	self.solid = false
    self.dustball = Assets.getFramesOrTexture("npcs/dw/dustball")
    self.dustball_index = 1
    self.mytime = 0
    self.myindex = 1
    self.physics.friction = 0.28 + math.random(0.08)
    self.physics.gravity = -0.44
    self.physics.speed_x = Utils.random(6) * Utils.pick({-2,2})
end

function dustball_pilebreak:draw()
    super.draw(self)
    Draw.draw(self.dustball[self.myindex], 0, 0, 0, 2, 2)
end

function dustball_pilebreak:update()
    super.update(self)
    self.mytime = self.mytime + (1 * DTMULT)
    self.myindex = Utils.clamp(Utils.ceil(self.mytime / 8), 1, 3)
    if self.mytime >= 30 then
        self.alpha = Utils.lerp(self.alpha, 0, 0.5 * DTMULT)
    end
    if self.mytime >= 40 then
        self.remove(self)
    end
end

function dustball_pilebreak:onInteract(chara, dir)
    return true
end

return dustball_pilebreak