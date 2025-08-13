local wobblebullet, super = Class(WorldBullet)

function wobblebullet:init(x, y, dir)
    super.init(self, x, y, "bullets/wobblebullet")

    self.damage = 20

    self.physics.direction = dir
    self.physics.speed = 10
    self.physics.friction = 0

    self.alpha = 0
    self:fadeToSpeed(1, 0.1)

    self.start_y = y
end

function wobblebullet:update()
    if math.abs(self.y - self.start_y) >= self.world.map.tile_width * 6 then
        self:fadeOutSpeedAndRemove(0.1)
    end

    super.update(self)
end

return wobblebullet