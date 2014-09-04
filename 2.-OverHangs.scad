/**
  * How does your printer handle overhang?  
  *   The rumour is 45 degrees and less should be safe.
  */

$fn=200;

gNumTowers = 8;
gMaxOverHang = 90;
gMinOverHang = 0;

gCylinderHeight=5;
gCylinderRadius=20;

gTowerDimension=5;
gTowerHeight=20;
gTowerLedge=gTowerHeight;

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

