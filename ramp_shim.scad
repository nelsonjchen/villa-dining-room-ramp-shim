// ==========================================
// CONFIGURATION
// ==========================================

// --- Dimensions (mm) ---
back_height_mm   = 26.57;
front_height_mm  = 10.3;
block_width_mm   = 50.0;
cutout_radius_mm = back_height_mm / 2;

// --- Base Settings ---
extra_base_height_mm = 30.0;
base_offset_mm       = 22.75;

// --- Wall Settings ---
wall_thickness   = 1.0; // How thick the outline should be

// ==========================================
// CALCULATIONS
// ==========================================
target_angle = asin(5.75 / 23);
rise = back_height_mm - front_height_mm;
total_ramp_length = rise / tan(target_angle);
base_start_x = cutout_radius_mm - base_offset_mm;
base_length  = total_ramp_length - base_start_x;

// ==========================================
// RENDER
// ==========================================

difference() {

    // 1. The "Outline" Extrusion
    // We create the 2D shape, subtract a smaller version of itself, then extrude.
    linear_extrude(height = block_width_mm) {
        difference() {
            // A. The Full 2D Shape (Union of Ramp + Base)
            union() {
                // Ramp part
                polygon(points = [
                    [0, 0],
                    [total_ramp_length, 0],
                    [total_ramp_length, front_height_mm],
                    [0, back_height_mm]
                ]);
                // Base part
                translate([base_start_x, -extra_base_height_mm])
                    square([base_length, extra_base_height_mm]);
            }

            // B. The Inner "Void" (The same shape, shrunk by wall_thickness)
            offset(r = -wall_thickness) {
                union() {
                    polygon(points = [
                        [0, 0],
                        [total_ramp_length, 0],
                        [total_ramp_length, front_height_mm],
                        [0, back_height_mm]
                    ]);
                    translate([base_start_x, -extra_base_height_mm])
                        square([base_length, extra_base_height_mm]);
                }
            }
        }
    }

    // 2. The Cylinder Cutout
    // We cut this AFTER extruding to ensure it cuts through the walls
    color("red")
    translate([0, back_height_mm - cutout_radius_mm, -1]) {
        cylinder(h = block_width_mm + 2, r = cutout_radius_mm, $fn = 100);
    }
}

// ==========================================
// DATA OUTPUT
// ==========================================
echo(str("Wall Thickness: ", wall_thickness, " mm"));