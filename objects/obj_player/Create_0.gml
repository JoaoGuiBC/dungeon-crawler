// Initializing variables
hspd = 0;
vspd = 0;
max_spd = 6;
spd = 0;
move_dir = 0;
accuracy = 0.5;

attack_types = [obj_knife, obj_fire, obj_water, obj_rock];
selected_attack = 0;
attack_delay = 0;

// Create knife
knife = instance_create_layer(x, y, "attacks", obj_knife);

create_knife = function() {
	knife = instance_create_layer(x, y, "attacks", obj_knife); 
}

// Attack 
create_attack = function() {
	if (attack_delay <= 0) {
		if (selected_attack == 0) {
			knife.slash();
			attack_delay = knife.attack_speed * (room_speed / 4);
		} else {
			var _attack = instance_create_layer(x, y, "attacks", attack_types[selected_attack]);
	
			_attack.speed = 8;
			_attack.direction = point_direction(_attack.x, _attack.y, mouse_x, mouse_y) + (random_range(-_attack.imprecision, _attack.imprecision) * accuracy);
		
			var _dir = point_direction(x, y, mouse_x, mouse_y);
		
			var _diff = angle_difference(_dir, image_angle);
			_attack.image_angle += median(-500, _diff, 500);
			
			attack_delay = _attack.attack_speed * (room_speed / 4);
		}
	}
}

// Hide mouse
window_set_cursor(cr_none);