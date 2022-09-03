var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var left = keyboard_check(ord("A"));
var right = keyboard_check(ord("D"));

var attack = mouse_check_button(mb_left);
var reset_attack_time = mouse_check_button_released(mb_left);

if (up || down || left || right) {
	move_dir = point_direction(0, 0, (right - left), (down - up));
	spd = lerp(spd, max_spd, 0.15);
} else {
	spd = lerp(spd, 0, 0.15);
}

hspd = lengthdir_x(spd, move_dir);
vspd = lengthdir_y(spd, move_dir);


if (attack) {
	i += 1;
	i = i mod 50;
	
	if (i == 0) {
		var _attack = instance_create_layer(x, y, "attacks", obj_rock);
	
		_attack.speed = 5;
		_attack.direction = point_direction(_attack.x, _attack.y, mouse_x, mouse_y);
		
		var _dir = point_direction(x, y, mouse_x, mouse_y);
		
		var _diff = angle_difference(_dir, image_angle);
		_attack.image_angle += median(-500, _diff, 500);
		
		knife.slash();
	}
}

if (reset_attack_time) {
	i = -1;	
}