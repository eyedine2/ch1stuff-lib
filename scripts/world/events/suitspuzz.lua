---@class suitspuzz : Event
---@field suits_max         integer     *[property `suits_max`]* The max of the puzzle (typical values are 3 - 5)
---@field solutionid        string   *[property `solutionid`]* An array of strings representing the solution
---@field cutscene  string  *[Property `cutscene`]* The name of a cutscene to start when victory is achieved
---@overload fun(...) : suitspuzz
local suitspuzz, super = Class(Event)

function suitspuzz:init(data)
    super.init(self, data)
    properties = data.properties or {}
    -- solution to the puzzle. Works even if it's longer than the max.
    if Game.world.map.id == "testsuits" then
        self.solution = {2,4,3,1}
    else
        self.solution = {1,1,1,1}
    end
    -- Suits
    self.suit = {}
    -- Maximum for the puzzle
    self.max = data.properties["suits_max"] or 3
    -- Which part of the suits array we're on
    self.input = 0
    -- if you won
    self.won = 0
    -- Victory coordinate that'll pop the won event if suits = solution for the whole array.
    self.victory = 0
    -- The button objects present in the map.
    self.mychildren = Game.world.map:getEvents("suitspuzz_but")
    for i = 1, self.max do
        self.suit[i] = 5
    end
    -- Cutscene
    self.cutscene = properties["cutscene"] or "none"
end

function suitspuzz:myevent(myevent)
    --[[ myevents
    1 = spade
    3 = diamond
    5 = swap
    --]]

    if self:getFlag("solved", false) == false then

        if myevent == 5 then

            for i = 1,self.max do
                if self.suit[i] == 1 then self.suit[i] = 3 elseif self.suit[i] == 3 then self.suit[i] = 1 end
                if self.suit[i] == 2 then self.suit[i] = 4 elseif self.suit[i] == 4 then self.suit[i] = 2 end
            end

        end

        if self.input < self.max then

            if myevent == 1 then
                self.input = self.input + 1
                self.suit[self.input] = 1
            end

            if myevent == 3 then
                self.input = self.input + 1
                self.suit[self.input] = 2
            end

        elseif myevent ~= 5 then

            --reset
            self.input = 0
            for i = 1,self.max do
                if self.suit[i] == self.solution[i] then
                    self.victory = self.victory + 1
                else
                    self.victory = 0
                end
                self.suit[i] = 5
            end
            
        end

    end
end

function suitspuzz:draw()
   super.draw(self)
    for i = 1,self.max do
        Draw.draw(Assets.getFramesOrTexture("puzzle/suitsicon")[self.suit[i]], 40 * (i - 1), 0, 0, 2, 2)
   end
end

function suitspuzz:update()
    super.update(self)

    if self.victory == self.max and self:getFlag("solved", false) == false then
        for _, child in ipairs(self.mychildren) do
            child:myevent()
        end
        self:setFlag("solved", true)
        if self.cutscene ~= "none" then
            Game.world:startCutscene(self.cutscene)
        end
    end

    if self:getFlag("solved") == true then
        self.suit = self.solution
    end

    return true
end

function suitspuzz:getDebugInfo()
    local info = super.getDebugInfo(self)
    if self.suit then
        table.insert(info, self.suit)
        table.insert(info, self.solution)
        table.insert(info, "Max:" .. self.max .. " ")
        table.insert(info, "Input:" .. self.input .. " ")
        table.insert(info, "Victory:" .. self.victory .. " ")
        table.insert(info, "Won:" .. self.won .. " ")
    end
    return info
end

return suitspuzz