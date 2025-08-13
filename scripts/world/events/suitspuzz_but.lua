---@class suitspuzz_but : Event
---
---@field myid         integer
---
---@overload fun(...) : suitspuzz_but
local suitspuzz_but, super = Class(Event)

function suitspuzz_but:init(data)
    super.init(self, data)
    properties = data.properties or {}
    self.myid = properties["myid"] or 1
    self.can_use = 1
end

function suitspuzz_but:postLoad()
    self.suitspuzz = Game.world.map:getEvent("suitspuzz")
end

function suitspuzz_but:draw()
   super.draw(self)
    if self.can_use == 1 and self.suitspuzz:getFlag("solved", false) == false then
    Draw.draw(Assets.getFramesOrTexture("puzzle/suitsbutton")[self.myid], 0, 0, 0, 2, 2)
    else
        Draw.draw(Assets.getFramesOrTexture("puzzle/suitsbutton")[self.myid], 0, 0, 0, 2, 2)
    Draw.draw(Assets.getFramesOrTexture("puzzle/suitsbutton")[self.myid + 1], 0, 4, 0, 2, 2)
    end
end

function suitspuzz_but:update()
    super.update(self)
    return true
end

function suitspuzz_but:onInteract(player, dir)
    if self.can_use == 1 and self.suitspuzz:getFlag("solved", false) == false then
        self.suitspuzz:myevent(self.myid)
        Assets.playSound("noise")
    end
    return true
end

function suitspuzz_but:myevent()
    self.can_use = 0
end

return suitspuzz_but