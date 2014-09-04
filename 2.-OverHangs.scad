/**
  * How does your printer handle overhang?  
  *   The rumour is 45 degrees and less should be safe.
  */
/* [Global] */

// The quality of circular lines.
$fn=200; // [60:300]

/* [Towers] */

// How many towers should I build?
gNumTowers = 8; // [1:100]

// What's the maximum angle of overhang allowed?
gMaxOverHang = 90; // [-360:360]

// What's the minimum angle of overhang allowed?
gMinOverHang = 0; // [-360:360]

// The singular dimension in mm used for the tower's x and y
gTowerDimension=5; // [0.1 : 50]

// The tower's height in mm.
gTowerHeight=20; // [0.1 : 100]

// How long is the ledge off the tower, in mm
gTowerLedge=gTowerHeight; // [0.1 : 100]

/* [Cylinder Base] */

// How tall the cylindrical base is, in mm.
gCylinderHeight=2; // [0.1 : 20]

// The radius of the base, in mm.  Will have the center carved out to minimize plastic waste.
gCylinderRadius=20; // [10 : 100]

/* [Hidden] */
tinyValue=0.01;

// Bottom plate
difference()
{
	cylinder(r=gCylinderRadius, h=gCylinderHeight, center=true);
	// Remove everything but the outside of the ring to speed up printing
	cylinder(r=gCylinderRadius-gTowerDimension, h=gCylinderHeight, center=true);
}

function OverhangDegreeForI(i) = (gMaxOverHang-gMinOverHang)/gNumTowers*i;

// Towers
for(i = [1 : gNumTowers])
{
	rotate([0,0,360/gNumTowers*i])
	translate([gCylinderRadius-gTowerDimension/2,0,gCylinderHeight/2+gTowerHeight/2])
	union()
	{
		translate([0,0,gTowerHeight/2])
		scale([1,1,1]*0.2)
		rotate([0,0,90])
		translate([-12.5,0,0])
		linear_extrude(height=5)
		text(str(floor(OverhangDegreeForI(i))), font="Arial");

		// Tower itself
		cube([gTowerDimension,gTowerDimension,gTowerHeight], center=true);

		// Ledge, at appropriate incline.
		rotate([0,OverhangDegreeForI(i),0])
		translate([sin(OverhangDegreeForI(i))*(gTowerHeight/2-gTowerDimension/4), 0, sin(OverhangDegreeForI(i))*(gTowerHeight/2-gTowerDimension/2)])
		cube([gTowerDimension/2, gTowerDimension, gTowerHeight], center=true);
	}
}

