// Behavior state
state = noone;

hspd = 0;
vspd = 0;

sprite = spr_enemy1;
sprite_xscale = 1;
sprite_yscale = 1;

xfov = 250;
yfov = 2;

target = noone;

state_time = room_speed * 3;
state_timer = 0;

y_destiny = y;
x_destiny = x;
spd = 2;

/// @method fov(width, height, xscale)
fov = function(_width, _height, _xscale) {
	var _x1, _x2, _y1, _y2;
	_x1 = x;
	_x2 = _x1 + _width * _xscale;
	_y1 = y + _height / 2 - sprite_height / 2;
	_y2 = _y1 - _height;
	
	var _target = collision_rectangle(_x1, _y1, _x2, _y2, obj_player, 0, 1);
	
	return _target;
}

change_state = function(_state) {
	state_time--;
	state_timer = irandom(state_time);
	
	// When timer is over, set another state
	if (state_timer == state_time || state_time <= 0) {
		state = _state[irandom(array_length(_state) - 1)];
		state_time = room_speed * 3;
	}
}

redraw_sprite = function() {
	draw_sprite_ext(sprite, image_index, x, y, sprite_xscale, sprite_yscale, image_angle, image_blend, image_alpha);
}

// Creating the behaviors that the enemy can have
idle_state = function() {
	// Do nothing
	hspd = 0;
	vspd = 0;
	
	// Looking forward
	target = fov(xfov, sprite_height * yfov, sprite_xscale);
	
	if (target) {
		state = chase_state;
	}
	
	// Check if it should change the selected behavior
	change_state([walking_state, idle_state]);
};
walking_state = function() {
	// Walk
	
	// Check if is close to previous destiny
	var _destiny = point_distance(x, y, x_destiny, y_destiny);
	
	// Choose a new direction if previous destiny is close
	if (_destiny < 75) {
		x_destiny = random(room_width);
		y_destiny = random(room_height);
	}
	
	var _dir = point_direction(x, y, x_destiny, y_destiny);
	
	// Looking to the right side
	if (hspd != 0) {
		sprite_xscale = sign(hspd);
	}
	
	// Moving to the destiny
	spd = random_range(0.5, 2)
	hspd = lengthdir_x(spd, _dir);
	vspd = lengthdir_y(spd, _dir);
	
	// Looking forward
	target = fov(xfov, sprite_height * yfov, sprite_xscale);
	
	if (target) {
		state = chase_state;
	}
	
	// Check if it should change the selected behavior
	change_state([idle_state, walking_state]);
};
chase_state = function() {
	// Check if target exists
	if (instance_exists(target)) {
		// Get target direction
		var _dir = point_direction(x, y, target.x, target.y);
		
		// Move into target direction
		spd = 2.5;
		hspd = lengthdir_x(spd, _dir);
		vspd = lengthdir_y(spd, _dir);
		
		// Get target distance
		var _dist = point_distance(x, y, target.x, target.y);
		
		// If target is far, stop chase
		if (_dist > xfov * 1.5) {
			state = idle_state;
		}
	} else {
		change_state([idle_state, walking_state]);
	}
}

state = idle_state;