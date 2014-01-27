class CupMesh{
	PVector[] verts;
	int uCount, vCount; //u=horizontal, v=vertical 

	CupMesh(int _uCount, int _vCount){
		uCount = _uCount;
		vCount = _vCount;
		verts = new PVector[uCount * vCount];
		for (int i = 0; i < verts.length; ++i) {
			verts[i] = new PVector(0,0,0);
		}
	}

	void update(PVector[] inputs){
		for (int i = 0; i < vCount; ++i) {
			for (int j = 0; j < uCount; ++j) {
				int vertIndex = uCount * i + j;
				pushMatrix();
					rotateY(j*TWO_PI/uCount); //rotation for radial res
					float vX = modelX(inputs[i].x, inputs[i].y, 0);
					float vY = modelY(inputs[i].x, inputs[i].y, 0);
					float vZ = modelZ(inputs[i].x, inputs[i].y, 0);
					verts[vertIndex].set(vX, vY, vZ);
					popMatrix();
				}		
			}
		}

	void display(){
		beginShape(QUADS);
		for (int i = 0; i < (verts.length-uCount); ++i) {
			int p1 = i;
			int p2 = i+1;
			int p3 = i+uCount+1;
			int p4 = i+uCount;
			if ((i+1) % uCount == 0) {
				p2 = i + 1 - uCount;
				p3 = i +1;
			}
			vertex(verts[p1].x, verts[p1].y, verts[p1].z);
			vertex(verts[p2].x, verts[p2].y, verts[p2].z);
			vertex(verts[p3].x, verts[p3].y, verts[p3].z);
			vertex(verts[p4].x, verts[p4].y, verts[p4].z);
		}
		endShape();
	}
}