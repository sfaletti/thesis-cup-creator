class ControlPoint{
	PVector pos;
	PShape displayPoint;
	float pointSize;
	boolean isUnder;

	ControlPoint(PVector p){
		pos = p.get();
		pointSize = 10;
		isUnder = false;
	}

	void setDrag(PVector mPos){
		if (pos.dist(mPos) <= pointSize) {
			isUnder = true;
		}
	}

	void move(PVector mPos){
		if (isUnder) pos = mPos.get();
	}

	void drop(PVector mPos){
		if (isUnder) {
			isUnder = false;
		}
	}

	void display(){
		fill(50,50,200);
		stroke(155);
		strokeWeight(2);
		ellipseMode(CENTER);
		ellipse(pos.x, pos.y, pointSize, pointSize);
	}
	
}