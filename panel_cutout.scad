// Parametric Rectangular Panel with D-Shaped Switch Cutouts

// --- Main Panel Parameters ---
// Change these values to resize your panel. All units are in mm.

panel_width = 6.5*25.4;    // How wide the panel is
panel_height = 0.5*25.4;    // How tall the panel is
panel_thickness = 1.6; // The thickness of the material (e.g., 1.6mm for 16 gauge)


// --- Switch Cutout Parameters ---
// These are from the datasheet and should not be changed.
switch_diameter = 10;
switch_flat_distance = 9.7;


// --- Reusable Modules ---

// Module to create a single D-shaped ("flat tire") hole.
module d_hole() {
    // The hole is made by taking a cylinder and cutting off one side.
    difference() {
        // Start with a round hole.
        // It's made taller than the panel to ensure a clean cut.
        cylinder(h = panel_thickness * 2, d = switch_diameter, center = true, $fn = 100);
        
        // Cut off the top to make a flat side.
        // A cube is positioned to remove the top part of the cylinder.
        // The flat position is derived from the datasheet parameters.
        translate([0, switch_flat_distance, 0]) {
            cube([switch_diameter, switch_diameter, panel_thickness * 2], center = true);
        }
    }
}


// --- Geometry Generation ---
// This code uses the parameters and modules above to build the final part.

difference() {
    
    // 1. Create the main rectangular panel body.
    cube([panel_width, panel_height, panel_thickness], center = true);
    
    // 2. Create two D-shaped holes, 40mm apart, and subtract them.
    translate([-40, 0, 0]) {
        d_hole();
    }
    translate([40, 0, 0]) {
        d_hole();
    }
}
