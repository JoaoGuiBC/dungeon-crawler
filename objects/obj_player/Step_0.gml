var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));

hspd = (right - left) * max_spd;

vspd = (down - up) * max_spd;