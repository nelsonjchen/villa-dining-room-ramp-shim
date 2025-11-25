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

// We create a reusable module for the 2D shape so we don't have to type it twice.
// This module defines the Ramp + Base - The Circle Cutout.
module complete_2d_profile() {
    difference() {
        // 1. The Positive Shape (Ramp + Base)
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

        // 2. The Negative Shape (The Circle Cutout)
        // We do the cut in 2D right here!
        translate([0, back_height_mm - cutout_radius_mm]) {
            circle(r = cutout_radius_mm, $fn = 100);
        }
    }
}

// ==========================================
// RENDER
// ==========================================

linear_extrude(height = block_width_mm) {
    difference() {
        // A. The Outer Profile (with the bite taken out)
        complete_2d_profile();

        // B. The Inner Void
        // We shrink the profile by the wall thickness
        offset(r = -wall_thickness) {
            complete_2d_profile();
        }
    }
}

// ==========================================
// DATA OUTPUT
// ==========================================
echo(str("Wall Thickness: ", wall_thickness, " mm"));