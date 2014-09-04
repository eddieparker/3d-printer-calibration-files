/**
  * See how bed adherence is on this object.  To look for:
  *
  * - Do the corners lift?  
  * 	If so, calibrate your bed or end stops (for delta)
  *
  * - Is it uneven in thickness?
  * 	Calibrate your bed.
  */
gOneSide=50;
gThickness=2;

cube([gOneSide,gOneSide,gThickness],center=true);
