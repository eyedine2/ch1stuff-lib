# ch1stuff-lib
![promo](https://raw.githubusercontent.com/eyedine2/darkgrass-lib/refs/heads/main/repo/promo.png)

This is a library that recreates several elements from the first chapter of deltarune. Includes the wavy grass from the field of hopes and dreams, the wobbly things seen in the first dark areas, and the suits puzzle.

# Field of Hopes and Dreams Grass

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

# solid_controllable (spikes / invisible walls)

`solid_controllable` is an incredibly basic element meant to be manipulated by cutscenes. It can be an invisible wall, or a pair of spikes. Much like the grass, any image it will tile on the X and Y axes and it has many changeable fields. Here they are:


`maxframes (int)`
The number of frames in an animated image, set to 1 for static images. Defaults to `2` (currently does nothing)

`tilesize_width (int)`
The width of the tile you're using. Defaults to `40`.

`tilesize_height (int)`
The height of the tile you're using. Defaults to `40`.

`myimage (string)`
The image being rendered. Relative to sprites directory. Defaults to `"none"`.

`tilescale (number)`
the scale of the tile being rendered. Allows light world formatted tiles (20x20) to be scaled up. Defaults to `2`.

solid_controllable also contains a custom function called `turnoff()`, which can be called from other events. It simply toggles a flag to let the object know it's a pair of spikes that needs to be retracted.

# Wobbly things

the wobbly things seen in the first dark areas. They wobble when the player's X value is close to theirs, and can optionally be evil and shoot bullets. Referred to as `wobblything` in tiled. They take only one field

`evil (bool)`
Whether this is an evil guy that shoots bullets. Defaults to `false`.

# Suits puzzle

The main puzzle from deltarune chapter 1, seen mostly in the forest area.

The suits puzzle consists of two elements, `suitspuzz`, and `suitspuzz_but`. The former is the actual puzzle, while the latter is the buttons that send a signal to the puzzle. Each of these have configurable fields that you ***NEED*** to set to ensure they work.

`suitspuzz_butt`:

`myid (int)`
Acceptable values:

1 (spade)

3 (diamond)

5 (swap)

`suitspuzz`:

`suits_max (int)`
Defines the length of the puzzle. If this is not set, it caps to 3.

`solutionid (list)`
an array of ints to determine the solution of the puzzle.

These are every symbol in the puzzle:

1: spade

2: diamond

3: club

4: heart

`cutscene (string)`

The cutscene to play upon victory. Typically for removing spikes. Defaults to "none".

# Dust Pile
The `dustpile`s that appear in the first dark areas. Emits particles, animates, and can be destroyed by interacting with them. These are its fields:

`not_solid_on_use`
If the dustpile removes its collision on use. Defaults to `false`.

`cutscene (string)`

The cutscene to play upon interaction. Like the scene with susie in chapter 1. Defaults to "none".

# Eye Puzzle

The first puzzle encountered in the game in the cliffs area, enhanced to support whatever kind of eye=swapping things you can thing of

consists of two elements, `eye_puzzle`, and `eye_puzzle_switch`. The former is the actual puzzle, while the latter is the buttons that send a signal to the puzzle. Each of these have configurable fields that you ***NEED*** to set to ensure they work.

`eye_puzzle`:

`cutscene (string)`

The cutscene to play upon victory. Typically for removing spikes. Defaults to "none".

`length (int)`:

Defines the length of the puzzle. If this is not set, it caps to 3.

`eye_puzzle_switch`:

`behavior (list)`:

What this switch object does in relation to its other siblings. Should encompass the full list of the eye puzzle's length.

0 = ignore
1 = swap

setting this will also dynamically draw hints for the puzzle.

`myid (int)`:

Which number on the puzzle's array we are. Used for drawing only. Usually set to be incremental (left is 1, right is the end of the length array).
