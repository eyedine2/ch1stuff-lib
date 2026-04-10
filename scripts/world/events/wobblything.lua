---@class wobblything : Event
---
---@field evil      boolean     *[property `evil`]* If this is an evil guy who shoots bullets
---
---@field mode      string     *[property `mode`]* If the wobbly thing scans vertically or horizontally
---
---@overload fun(...) : wobblything
local wobblything, super = Class(Event)

function wobblything:init(data)
    super.init(self, data.x, data.y, 39, 37)
    properties = data.properties or {}
    self:setOrigin(0.5, 0.75)
    self.evil = properties["evil"] or false
    self.mode = properties["mode"] or "vertical"

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
    local chara = Game.world.player
    super.update(self)
    if self.wobbled == false then
        if self.mode == "vertical" then
            if chara.x > (self.x - 10) and chara.x < (self.x + 50) then
                self:wobble()
            end
        elseif self.mode == "horizontal" then
            if chara.y > (self.y - 10) and chara.y < (self.y + 50) then
                self:wobble()
            end
        end
    end
end

function wobblything:wobble()
    Assets.playSound("wobbler",1,0.8 + Utils.random(0.3))
    self.sprite:play(6/30,true)
    self.wobbled = true
    if self.evil == true then
        for i = 1,3,1 do
            self.world:spawnBullet("wobblebullet", self.x, self.y, math.rad(45) * i)
        end
    end
end

return wobblything