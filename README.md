# darkgrass-lib
![promo](https://raw.githubusercontent.com/eyedine2/darkgrass-lib/refs/heads/main/repo/promo.png)

This is a library that recreates the wavy grass effect seen in deltarune chapter 1 inside fangame engine Kristal. It's highly customizable, and other cool words like that.

# Using

Basic usage involves creating a square called `darkgrass` on an `objects` layer in Tiled. Make sure the layer is beneath the one the player spawns on by creating an `objects1` layer below your uppermost objects layer and putting the object there.

That's not all, however. You can change a few properties about this effect in Tiled itself using properties.

`maxframes (int)`
The number of frames in an animated image, set to 1 for static images. Defaults to `9`.

`tilesize_width (int)`
The width of the tile you're using. Defaults to `40`.

`tilesize_height (int)`
The height of the tile you're using. Defaults to `40`.

`grassimage (string)`
The image being rendered. Relative to sprites directory. Defaults to `"rooms/dw/darkgrass_middle"`.

`tilescale (number)`
the scale of the tile being rendered. Allows light world formatted tiles (20x20) to be scaled up. Defaults to `1`.

`animspeed (number)`
the speed of the animation. Defaults to `6`.
