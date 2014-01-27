ArrayList<ControlPoint> points;
ControlArea controlArea;
CupMesh cupMesh;
int cupVRes = 30;
int cupRadRes = 30;

void setup() {
 size(1000, 600, P3D);
	controlArea = new ControlArea(250, 500, width-300, 50);
	points = new ArrayList<ControlPoint>();
	for (int i = 0; i < 4; ++i) {
		points.add(new ControlPoint(new PVector(width-250+random(150), i*(height*.2)+(height*.2))));		
	}
	cupMesh = new CupMesh(cupRadRes, cupVRes); //1st val=radial res, 2nd=vertical res
	cupMesh.update(getSegs(cupVRes));
}

void draw() {
	background(200);
	lights();
	controlArea.display();
	drawControl();
	drawContour();
	// drawSegs(getSegs(cupVRes));
	cupMesh.display();
	for (ControlPoint p : points) {
		p.display();
	}
}

PVector[] getSegs(int steps){
	PVector[] segs = new PVector[steps];
	float[] xPositions = new float[points.size()];
	float[] yPositions = new float[points.size()];
	for (int i = 0; i < points.size(); ++i) {
		xPositions[i] = points.get(i).pos.x;
		yPositions[i] = points.get(i).pos.y;
	}
	for (int i = 0; i < steps; ++i) {
		float t = i / float(steps);
		float x = bezierPoint(xPositions[0], xPositions[1], xPositions[2], xPositions[3], t);
		float y = bezierPoint(yPositions[0], yPositions[1], yPositions[2], yPositions[3], t);
		segs[i] = new PVector(x-(width-300), y-50);
	}
	return segs;
}

void drawSegs(PVector[] _segs){
	ellipseMode(CENTER);
	for (int i = 0; i < _segs.length; ++i) {
		ellipse(_segs[i].x, _segs[i].y, 5, 5);
	}
}

void drawContour(){
		stroke(0, 150);
		noFill();
		strokeWeight(5);
		beginShape();
			vertex(points.get(0).pos.x, points.get(0).pos.y); //control point at first vertex
			for (int i=2; i<points.size()-1; i++) {
				PVector cp1 = points.get(i-1).pos;
				PVector cp2 = points.get(i).pos;
				PVector cp3 = points.get(i+1).pos;
				bezierVertex(cp1.x, cp1.y, 0, cp2.x, cp2.y, 0, cp3.x, cp3.y, 0);
			}
		endShape();
}

void drawControl(){
		stroke(100);
		strokeWeight(1);
		noFill();
		beginShape();
		for (ControlPoint p : points) {
			vertex(p.pos.x, p.pos.y);
		}
		endShape();
}

void mousePressed() {
	for (ControlPoint p : points) {
		p.setDrag(mVect());
	}
}

void mouseDragged() {
	for (ControlPoint p : points) {
		if (controlArea.isIn(mVect())) p.move(mVect());
	}	
	cupMesh.update(getSegs(cupVRes));

}

void mouseReleased() {
	for (ControlPoint p : points) {
		p.drop(mVect());
	}
	cupMesh.update(getSegs(cupVRes));
}

void keyReleased() {
	int counter = 0;
	for (ControlPoint p : points) {
		counter ++;
		println(counter + ": " + p.pos.x + ", " + p.pos.y);
	}
}

PVector mVect() {
	return new PVector(mouseX, mouseY);
}

