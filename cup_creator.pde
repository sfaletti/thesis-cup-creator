ArrayList<ControlPoint> points;
segCount = 30;

void setup() {
	size(250, 500);
	points = new ArrayList<ControlPoint>();
	for (int i = 0; i < 4; ++i) {
		points.add(new ControlPoint(new PVector(width/2+random(-width/3, width/3), (i*(height*.95)/4)+height*.1)));		
	}
	if (javascript != null) {
		javascript.updateCurveSegs(segCount);
	}
	noLoop();
}

void draw() {
	background(255);
	drawContour();
	drawControl();
	for (ControlPoint p : points) {
		p.display();
	}
}

void drawContour(){
	stroke(255, 50, 50);
	fill(0);
	strokeWeight(8);
	strokeJoin(ROUND);
	beginShape();
	vertex(0, points.get(0).pos.y);
	vertex(points.get(0).pos.x, points.get(0).pos.y); //control point at first vertex
	for (int i=2; i<points.size()-1; i++) {
		PVector cp1 = points.get(i-1).pos;
		PVector cp2 = points.get(i).pos;
		PVector cp3 = points.get(i+1).pos;
		bezierVertex(cp1.x, cp1.y, cp2.x, cp2.y, cp3.x, cp3.y);
	}
	vertex(0, points.get(points.size()-1).pos.y);
	endShape();
}

void drawControl(){
	stroke(180);
	strokeWeight(1);
	noFill();
	beginShape();
	for (ControlPoint p : points) {
		vertex(p.pos.x, p.pos.y);
	}
	endShape();
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

void mousePressed() {
	for (ControlPoint p : points) {
		p.setDrag(mVect());
	}
}

void mouseDragged() {
	for (ControlPoint p : points) {
		if (p.isUnder && (mouseX > 0 && mouseX < width) && (mouseY > 0 && mouseY < height)) {
			p.move(mVect());
			redraw();
			if (javascript != null) {
				javascript.updateCurveSegs(segCount);
			}	
		}
	}
}

void mouseReleased() {
	for (ControlPoint p : points) {
		p.drop(mVect());
	}
	if (javascript != null) {
		javascript.updateCurveSegs(segCount);
	}
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

interface Javascript {
	void updateCurveSegs(int segmentCount);
}

void bindJavascript(Javascript js) {
	javascript = js;
}

Javascript javascript;
