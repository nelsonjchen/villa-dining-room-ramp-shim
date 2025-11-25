// --- DIMENSIONS (mm) ---
back_height_mm = 26.57;    // The tall side of the ramp part
front_height_mm = 10.3;    // The short side (toe) of the ramp part
block_width_mm = 50.0;     // How deep the object is (Z axis)
cutout_radius_mm = back_height_mm / 2;    // RADIUS of the cylinder chunk to remove

// --- EXTRA BASE ---
extra_base_height_mm = 30; // Height of the extra material underneath

// --- ANGLE CALCULATION ---
target_angle = asin(5.75 / 23);

// --- GEOMETRY MATH ---
rise = back_height_mm - front_height_mm;
calculated_length = rise / tan(target_angle);

// extra length

// Fit futher back a bit underneath the cylinder cutout
extra_calculated_length = calculated_length ;

// --- RENDER ---
// OpenSCAD automatically combines (unions) shapes listed sequentially.

// 1. THE ORIGINAL RAMP & CUTOUT
// This part sits above Y=0
difference() {
    // The Base Trapezoid Shape
    linear_extrude(height = block_width_mm) {
        polygon(points = [
            [0, 0],
            [calculated_length, 0],
            [calculated_length, front_height_mm],
            [0, back_height_mm]
        ]);
    }

    // The Cylinder to Subtract
    translate([0, back_height_mm - cutout_radius_mm, -1]) {
        cylinder(h = block_width_mm + 2, r = cutout_radius_mm, $fn = 100);
    }
}

// 2. THE EXTRA BASE MATERIAL
// This part is shifted down to sit below Y=0
translate([0 + cutout_radius_mm - 22.75 , -extra_base_height_mm, 0]) {
    // Creates a block: [length (X), height (Y), depth (Z)]
    cube([extra_calculated_length + 22.75 - cutout_radius_mm, extra_base_height_mm, block_width_mm]);
}


// --- DATA OUTPUT ---
echo("------------------------------------------------");
echo(str("Total Back Height: ", back_height_mm + extra_base_height_mm, " mm"));
echo(str("Extra Base Height: ", extra_base_height_mm, " mm"));
echo("------------------------------------------------");