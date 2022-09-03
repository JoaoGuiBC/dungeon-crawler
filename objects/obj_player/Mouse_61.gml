// Select next attack
if (selected_attack < 4) {
	selected_attack++;
	
	// Destroy knife when is unselected
	if (selected_attack == 1) {
		instance_destroy(knife.id);
	}
}