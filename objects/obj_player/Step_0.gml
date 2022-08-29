var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));

if (up || down || left || right) {
	move_dir = point_direction(0, 0, (right - left), (down - up));
	spd = lerp(spd, max_spd, 0.15);
} else {
	spd = lerp(spd, 0, 0.15);
}

hspd = lengthdir_x(spd, move_dir);
vspd = lengthdir_y(spd, move_dir);