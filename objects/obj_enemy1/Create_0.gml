// Behavior state
state = noone;

hspd = 0;
vspd = 0;

sprite = spr_enemy1;
sprite_xscale = 1;
sprite_yscale = 1;

state_time = room_speed * 3;
state_timer = 0;

y_destiny = y;
x_destiny = x;
spd = 2;

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
stopped_state = function() {
	// Do nothing
	hspd = 0;
	vspd = 0;
	
	// Check if it should change the selected behavior
	change_state([walking_state, stopped_state]);
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
	
	// Check if it should change the selected behavior
	change_state([stopped_state, walking_state]);
};

state = stopped_state;