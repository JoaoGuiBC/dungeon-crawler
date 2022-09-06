// Horizontal collision
if (place_meeting(x + hspd, y, obj_wall)) {
	var _hspd = sign(hspd);
	
	while (!place_meeting(x + _hspd, y, obj_wall)) {
		x += _hspd;
	}
	
	hspd = 0;
}

x += hspd;

// Vertical collision
if (place_meeting(x, y + vspd, obj_wall)) {
	var _vspd = sign(vspd);
	
	while (!place_meeting(x, y + _vspd, obj_wall)) {
		y += _vspd;
	}
	
	vspd = 0;
}

y += vspd;