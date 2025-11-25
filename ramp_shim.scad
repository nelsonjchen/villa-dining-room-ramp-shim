// ==========================================
// CONFIGURATION
// ==========================================

// --- Dimensions (mm) ---
back_height_mm   = 26.57;   // The tall side of the ramp part
front_height_mm  = 10.3;    // The short side (toe) of the ramp part
block_width_mm   = 50.0;    // Depth of the object (Z axis)
cutout_radius_mm = back_height_mm / 2; // Radius of the cylinder cut

// --- Base Settings ---
extra_base_height_mm = 30.0;  // Height of the extra material underneath
base_offset_mm       = 22.75; // The manual offset (from your screenshot)

// ==========================================
// CALCULATIONS
// ==========================================

// --- Angle Math ---
// Target angle based on original 5.75/23 ratio
target_angle = asin(5.75 / 23);

// --- Length Math ---
rise = back_height_mm - front_height_mm;
total_ramp_length = rise / tan(target_angle);

// --- Base Positioning Math ---
// Calculate where the base starts and how long it needs to be 
// to align with the front of the ramp.
base_start_x = cutout_radius_mm - base_offset_mm;
base_length  = total_ramp_length - base_start_x;

// ==========================================
// RENDER
// ==========================================

// 1. TOP SECTION: RAMP & CUTOUT
color("Goldenrod") 
difference() {
    // A. The Ramp Shape
    linear_extrude(height = block_width_mm) {
        polygon(points = [
            [0, 0],
            [total_ramp_length, 0],
            [total_ramp_length, front_height_mm],
            [0, back_height_mm]
        ]);
    }

    // B. The Cylinder Cutout
    translate([0, back_height_mm - cutout_radius_mm, -1]) {
        cylinder(h = block_width_mm + 2, r = cutout_radius_mm, $fn = 100);
    }
}

// 2. BOTTOM SECTION: EXTRA BASE
// Shifts down and adjusts X to fit the calculated offset
color("FireBrick")
translate([base_start_x, -extra_base_height_mm, 0]) {
    cube([base_length, extra_base_height_mm, block_width_mm]);
}

// ==========================================
// CONSOLE OUTPUT
// ==========================================
echo("------------------------------------------------");
echo(str("Total Height: ", back_height_mm + extra_base_height_mm, " mm"));
echo(str("Base X Shift: ", base_start_x, " mm"));
echo("------------------------------------------------");