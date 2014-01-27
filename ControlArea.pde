class ControlArea{
	float w, h, xPos, yPos;
	float boundaryWeight;
	color boundaryColor;

	ControlArea(float _w, float _h, float _xPos, float _yPos){
		w = _w;
		h = _h;
		xPos = _xPos;
		yPos = _yPos;
		boundaryWeight = 10;
		boundaryColor = color(255);
	}

	boolean isIn(PVector mPos){
		//TODO expand so single direction mouse movements work. It's more intuitive that way
		float offset = 11;
		if ((mPos.x > xPos+offset && mPos.x < xPos+w-offset) && (mPos.y > yPos+offset && mPos.y < yPos+h-offset)) return true;
		return false;
	}

	void display(){
		noFill();
		stroke(boundaryColor);
		strokeWeight(boundaryWeight);
		rect(xPos, yPos, w, h);
	}
}