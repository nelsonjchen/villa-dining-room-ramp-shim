// ==========================================
// CONFIGURATION
// ==========================================

// --- Dimensions (mm) ---
is_dining_room = false; // true = dining room (10.3mm), false = living room (18.0mm)

back_height_mm   = 26.57;
front_height_mm  = is_dining_room ? 10.3 : 20.0;
block_width_mm   = 50.0;
cutout_radius_mm = back_height_mm / 2;

// --- New Feature: Rectangular Overhang ---
overhang_length_mm = 20.0; // How far it sticks out
lip_thickness_mm   = 1.0;  // How thick the rectangular tab is

// --- Base Settings ---
extra_base_height_mm = 5.0;
base_offset_mm       = 22.75;

// --- Wall Settings ---
wall_thickness   = 1.0;

// ==========================================
// CALCULATIONS
// ==========================================
target_angle = asin(5.75 / 23);
rise = back_height_mm - front_height_mm;
total_ramp_length = rise / tan(target_angle);
base_start_x = cutout_radius_mm - base_offset_mm;
base_length  = total_ramp_length - base_start_x;

// ==========================================
// MODULES
// ==========================================

module complete_2d_profile() {
    difference() {
        // 1. The Positive Shapes (Union together)
        union() {
            // A. Original Ramp part
            polygon(points = [
                [0, 0],
                [total_ramp_length, 0],
                [total_ramp_length, front_height_mm],
                [0, back_height_mm]
            ]);

            // B. Base part
            translate([base_start_x, -extra_base_height_mm])
                square([base_length, extra_base_height_mm]);

            // C. NEW: Rectangular Lip Extension
            // We translate to the top-front corner
            translate([total_ramp_length, front_height_mm])
                // Rotate to match the slope (negative angle)
                rotate([0, 0, -target_angle])
                    // Draw the rectangle hanging "down" from that corner
                    // [Length, Thickness] - We translate Y down by thickness to align top edge
                    translate([0, -lip_thickness_mm])
                        square([overhang_length_mm, lip_thickness_mm]);
        }

        // 2. The Negative Shape (The Circle Cutout)
        translate([0, back_height_mm - cutout_radius_mm]) {
            circle(r = cutout_radius_mm, $fn = 100);
        }
    }
}

// ==========================================
// RENDER
// ==========================================

linear_extrude(height = block_width_mm) {
    intersection() {
        // 1. The Hollow 2D Shape
        difference() {
            complete_2d_profile();
            offset(r = -wall_thickness) {
                complete_2d_profile();
            }
        }

        // 2. The Floor Cut
        // Slices off the bottom based on your base height
        floor_level_y = -extra_base_height_mm + wall_thickness;
        translate([-500, floor_level_y])
            square([2000, 2000]);
    }
}

// ==========================================
// DATA OUTPUT
// ==========================================
echo(str("Lip Extension: ", overhang_length_mm, "mm long x ", lip_thickness_mm, "mm thick"));