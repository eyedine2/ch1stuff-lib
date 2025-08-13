---@class dustpile : Event
---
---
---@overload fun(...) : dustpile
local dustpile, super = Class(Event)

function dustpile:init(data)
    super.init(self, data.x, data.y, 126, 92)
    properties = data.properties or {}
    self:setOrigin(0.5, 0.5)
	self.solid = true
    self.dust = Assets.getFramesOrTexture("npcs/dw/dustpile_parts")
    self.siner = 0
    self.mytime = 0
    self.r = 30
    self.collider = Hitbox(self,0,63,126,32)
end

function dustpile:draw()
    super.draw(self)
    Draw.draw(self.dust[4], 0, 0, 0, 2, 2)
    if self:getFlag("bust", false) == false then
        Draw.draw(self.dust[1], math.sin(self.siner / 5), math.sin(self.siner / 5), 0, 2, 2)
        Draw.draw(self.dust[2], math.cos(self.siner / 5), math.sin(self.siner / 5), 0, 2, 2)
        Draw.draw(self.dust[3], -math.sin(self.siner / 5), math.sin(self.siner / 5), 0, 2, 2)
    end
end

function dustpile:update()
    super.update(self)
    self.siner = Utils.clampWrap(self.siner + .5 * DTMULT, 60)
    if self:getFlag("bust", false) == false then
        self.mytime = self.mytime + (1 * DTMULT)
        if self.mytime >= self.r then
            Game.world:spawnObject(Registry.createEvent("dustball", {x = self.x, y = self.y, properties = {}}))
            self.r = Utils.random(60, 300)
            self.mytime = 0
        end
    end
end

function dustpile:onInteract(chara, dir)
    if self:getFlag("bust", false) == false then
        self:setFlag("bust", true)
        Assets.playSound("cough")
        Game.world:shakeCamera()
        for i = 1, 13 do
            Game.world:spawnObject(Registry.createEvent("dustball_pilebreak", {x = self.x + Utils.pick({20,-20}) + (i * Utils.pick({6, -6})), y = self.y + 20 + math.random(25), properties = {pilebreak = true}}))
        end
    end
    return true
end

return dustpile