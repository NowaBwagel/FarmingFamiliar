shader_type canvas_item;

uniform float offset = 0.5;
uniform float speed = 1.0;

void vertex() {
	if (VERTEX.y < 0.0){
		VERTEX.x += cos(speed * (TIME + offset)) * 0.5 * (VERTEX.y - 38.0) * 0.1;
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
