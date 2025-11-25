// --- DIMENSIONS (mm) ---
back_height_mm = 26.57;    // The tall side
front_height_mm = 10.3;     // The short side (toe)
block_width_mm = 50.0;     // How deep the object is
cutout_radius_mm = back_height_mm / 2;    // RADIUS of the cylinder chunk to remove

// --- ANGLE CALCULATION (Based on original request) ---
target_angle = asin(5.75 / 23);

// --- GEOMETRY MATH ---
rise = back_height_mm - front_height_mm;
calculated_length = rise / tan(target_angle);

// --- RENDER ---
difference() {
    // 1. The Base Shape (The Trapezoidal Prism)
    linear_extrude(height = block_width_mm) {
        polygon(points = [
            [0, 0],                         // Bottom Left (Back)
            [calculated_length, 0],         // Bottom Right (Front)
            [calculated_length, front_height_mm], // Top Right
            [0, back_height_mm]             // Top Left (The corner to cut)
        ]);
    }

    // 2. The Cylinder to Subtract
    // Position so the cylinder's top (max Y) is at the ramp top (back_height_mm)
    translate([0, back_height_mm - cutout_radius_mm, -1]) {
        cylinder(h = block_width_mm + 2, r = cutout_radius_mm, $fn = 100);
    }
}

// --- DATA OUTPUT ---
echo("------------------------------------------------");
echo(str("Cutout Radius: ", cutout_radius_mm, " mm"));
echo("------------------------------------------------");