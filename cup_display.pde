CupMesh cupMesh;

void setup() {
	size(500, 500, P3D);
	cupMesh = new CupMesh(30, 30);
	noLoop();
}

void draw() {
	background(255);
	lights();
	translate(125, 30, -150);
	stroke(20);
	strokeWeight(.5);
	fill(200);
	cupMesh.display();
}

void updateMesh(PVector[] points){
	cupMesh.update(points);
	redraw();
}

// void mouseDragged() {
// 	camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);	
// }

interface Javascript {
	void updateCurveSegs(int segmentCount);
}

void bindJavascript(Javascript js) {
	javascript = js;
}

Javascript javascript;