---@class solid_controllable : Event
---
---@field mytexture             love.Image
---
---@field tiles_x           integer
---@field tiles_y           integer
---@field maxframes         integer     *[Property `maxframes`]* The number of frames in the image
---@field tilesize_width    integer     *[property `tilesize_width`]* The width of whatever tile being used
---@field tilesize_height   integer     *[property `tilesize_height`]* The height of whatever tile being used
---
---@field myimage           string      *[Property `grassimage`]* The Image to use for the Grass
---
---@field tilescale         number     *[property `tilesize`]* The scale multiplier of whatever tile being used
---
---@overload fun(...) : solid_controllable
local solid_controllable, super = Class(Event)

function solid_controllable:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    properties = data.properties or {}
	self.solid = true
    self.id = "solid_controllable"
    self.tilesize_width = properties["tilesize_width"] or 40
    self.tilesize_height = properties["tilesize_height"] or 40
    self.tilescale = properties["tilescale"] or 1
    self.tiles_x = math.floor(self.width/self.tilesize_width)
    self.tiles_y = math.floor(self.height/self.tilesize_height)
    self.maxframes = properties["maxframes"] or 2
    self.myimage = properties["myimage"] or "none"
    self.frame = 1
    if self.myimage ~= "none" then
        self.mytexture = Assets.getFramesOrTexture(self.myimage)
    end
    self.c = 0
end

function solid_controllable:draw()
    super.draw(self)
    if self.myimage ~= "none" then
        for i = 1, self.tiles_x do
            for j = 1, self.tiles_y do
                Draw.draw(self.mytexture[self.frame], (i - 1) * self.tilesize_width, (j - 1) * self.tilesize_height, 0, self.tilescale, self.tilescale)
            end
        end
    end
end

function solid_controllable:update()
    super.update(self)
    if self:getFlag("off", false) == true then
        self.frame = 2
        self.solid = false
    end
end

function solid_controllable:turnoff()
    self:setFlag("off", true)
end

return solid_controllable