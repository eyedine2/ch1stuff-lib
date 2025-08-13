---@class wobblything : Event
---
---@field evil      boolean     *[property `evil`]* If this is an evil guy who shoots bullets
---
---@overload fun(...) : wobblything
local wobblything, super = Class(Event)

function wobblything:init(data)
    super.init(self, data.x, data.y, 39, 37)
    properties = data.properties or {}
    self:setOrigin(0.5, 0.75)
    self.evil = properties["evil"] or false

    if self.evil == true then
	    self:setSprite("npcs/dw/wobblything_evil",0)
    else
        self:setSprite("npcs/dw/wobblything",0)
    end

	self:addChild(self.sprite)
	self.solid = true
    self.wobbled = false
end

function wobblything:draw()
    super.draw(self)
end

function wobblything:update()
    local chara = Game.world:getCharacter("kris")
    super.update(self)
    if chara then
        if self.wobbled == false then
            if chara.x > (self.x - 10) and chara.x < (self.x + 50) then
                Assets.playSound("wobbler",1,0.8 + Utils.random(0.3))
                self.sprite:play(6/30,true)
                self.wobbled = true
                if self.evil == true then
                    for i = 1,3,1 do
                        self.world:spawnBullet("wobblebullet", self.x, self.y, math.rad(45) * i)
                    end
                end
            end
        end
    end
end

return wobblything