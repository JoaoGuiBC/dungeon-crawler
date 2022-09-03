// Select previous attack
if (selected_attack > 0) {
	selected_attack--;
	
	// Create knife when it is selected
	if (selected_attack == 0) {
		create_knife();
	}
}