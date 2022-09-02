// Horizontal collision and movement system
var _hspd = sign(hspd);

repeat(abs(hspd)) {
	// Check if the place where player will move to is already filled
	if (place_meeting(x + _hspd, y, obj_wall)) {
		// Stop moving if there is a collision with a wall
		hspd = 0;
	} else {
		// Keep moving if there is no collision with a wall
		x += _hspd
	}
}

// Vertical collision and movement system
var _vspd = sign(vspd);

repeat(abs(vspd)) {
	// Check if the place where player will move to is already filled
	if (place_meeting(x, y + _vspd, obj_wall)) {
		// Stop moving if there is a collision with a wall
		vspd = 0;
	} else {
		// Keep moving if there is no collision with a wall
		y += _vspd
	}
}

var _dir = point_direction(x, y, mouse_x, mouse_y);

var _x = x + lengthdir_x(sprite_width, _dir);
var _y = y + lengthdir_y(sprite_height, _dir);

knife.x = _x;
knife.y = _y;
knife.image_angle = _dir - 90;

if (mouse_x > x) {
	knife.image_xscale = -1;

} else {
	knife.image_xscale = 1;
}
