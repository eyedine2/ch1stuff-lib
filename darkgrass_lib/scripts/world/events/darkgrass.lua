--- Animated Grass for the Field Area. \
--- `darkgrass` is an [`Event`](lua://Event.init) - naming an object `darkgrass` on an `objects` layer in a map creates this object. \
--- See this object's Fields for the configurable properties on this object.
---@class darkgrass : Event
---
---@field grass             love.Image
---
---@field tiles_x           integer
---@field tiles_y           integer
---@field maxframes         integer     *[Property `maxframes`]* The number of frames in the animated image
---@field tilesize_width    integer     *[property `tilesize_width`]* The width of whatever tile being used
---@field tilesize_height   integer     *[property `tilesize_height`]* The height of whatever tile being used
---
---@field grassimage        string      *[Property `grassimage`]* The Image to use for the Grass
---
---@field tilescale         number     *[property `tilesize`]* The scale multiplier of whatever tile being used
---@field animspeed         number     *[property `animspeed`]* How quickly the wave effect animates
---
---@overload fun(...) : darkgrass
local darkgrass, super = Class(Event, "darkgrass")

function darkgrass:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    properties = data.properties or {}

    self.animspeed = properties["animspeed"] or 6
    self.tilesize_width = properties["tilesize_width"] or 40
    self.tilesize_height = properties["tilesize_height"] or 40
    self.tilescale = properties["tilescale"] or 1
    self.tiles_x = math.floor(self.width/self.tilesize_width)
    self.tiles_y = math.floor(self.height/self.tilesize_height)
    self.maxframes = properties["maxframes"] or 9
    self.grassimage = properties["grassimage"] or "rooms/dw/darkgrass_middle"
    self.frame = 1
    self.grass = Assets.getFramesOrTexture(self.grassimage)
    self.c = 0


end

function darkgrass:update()
    super.update(self)

end

function darkgrass:draw()
    super.draw(self)
    local id = 1
    for i = 1, self.tiles_x do
        for j = 1, self.tiles_y do
            Draw.draw(self.grass[Utils.clampWrap(Utils.round(self.frame + (self.x / 320) + (i * 0.125) + (j * 0.125) + (self.y / 320)),1 ,self.maxframes )], (i - 1) * self.tilesize_width, (j - 1) * self.tilesize_height, 0, self.tilescale, self.tilescale)
            id = id + 1
            
        end
    end
    if self.c >= 1 then
        self.frame = Utils.clampWrap((self.frame + 1), 1, self.maxframes)
        self.c = 0
    else
        self.c = self.c + (self.animspeed * DT)
    end

end

return darkgrass