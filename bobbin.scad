$fn=100;

bore_rad = 3.5;
hub_rad = 15;
thickness=9.5;
rim_thickness = 10;
spoke_width = 4;

module groove (radius) {
    rotate_extrude() 
    translate([radius-1, 0]) {
	translate([0, 4.5]) circle(r=2);
	difference() {
	    translate([-1, 0]) square(thickness);
	    translate([-1, thickness-0.75]) circle(r=2);
	    translate([-1,0.75]) circle(r=2);
	}
    }
}

module rim (radius) {
    difference () {
	cylinder (thickness, r=radius);
	cylinder (thickness, r=radius-rim_thickness);
	groove(radius);
    }
}

module hub() {
    difference() {
	union() {
	    translate ([0,0,thickness]) cylinder (10, r=6.5);
	    cylinder (thickness, r=hub_rad);
	}
	cylinder (thickness + 10, r=bore_rad);
    }
}

module spokes(radius, count) {
    for (i = [0:count]) {
	rotate ([0,0, 360 * i / count]) {
            translate ([hub_rad-2, -spoke_width/2, 0]) {
                cube ([radius - rim_thickness - hub_rad + 2,
               spoke_width,
                thickness]);
            };
        }
    }
}
    
module whorl (radius) {
    union() {
	hub(radius);
	rim(radius);
	spokes(radius, 13);
    }
}

whorl(55);
