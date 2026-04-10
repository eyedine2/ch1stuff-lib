---@class eye_puzzle : Event
---@field cutscene      string  *[Property `cutscene`]* The name of a cutscene to start when victory is achieved
---@field length    integer
---
---@overload fun(...) : eye_puzzle
local eye_puzzle, super = Class(Event)

function eye_puzzle:init(data)
    super.init(self, data.x, data.y, data.width,data.height)
    self.done = false
    properties = data.properties or {}
    self.sol = {}
    self.cutscene = properties["cutscene"] or "none"
    self.length = properties["length"] or 3
    self.progress = 0
    for i = 1, self.length do
        self.sol[i] = 0
    end


end
function eye_puzzle:draw()
    super.draw(self)

end

function eye_puzzle:update()
    if self.progress >= self.length then
         if self.done == false then
            self:setFlag("solved_eyepuzzle", true)
            if self.cutscene ~= "none" then
                Game.world:startCutscene(self.cutscene)
            end
        end
        self.done = true
    end
    super.update(self)
end

function eye_puzzle:myEventNew(event)
    if self:getFlag("solved_eyepuzzle", false) == false then
        Assets.playSound("noise")
            for i = 1, self.length do
                if event[i] == 1 then
                    if self.sol[i] == 1 then self.sol[i] = 0 else self.sol[i] = 1 end
                end
                if self.sol[i] == 1 then self.progress = self.progress + 1 else self.progress = 0 end
            end
    end
end

return eye_puzzle