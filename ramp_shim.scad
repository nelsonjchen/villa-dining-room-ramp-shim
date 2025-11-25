// --- DIMENSIONS (mm) ---
back_height_mm = 26.57;    // The tall side (Your requested height)
front_height_mm = 10;     // The short side (The "toe"). Must be > 0 to be 4-sided.
block_width_mm = 50.0;     // How deep the object is

// --- ANGLE CALCULATION ---
// Keeping the specific angle from your original 23" x 5.75" ramp
// sin(theta) = 5.75 / 23
target_angle = asin(5.75 / 23);

// --- GEOMETRY MATH ---
// We calculate the length automatically to ensure the angle stays perfect.
// tan(theta) = (Back - Front) / Length
// Therefore: Length = (Back - Front) / tan(theta)
rise = back_height_mm - front_height_mm;
calculated_length = rise / tan(target_angle);

// --- RENDER ---
linear_extrude(height = block_width_mm) {
    polygon(points = [
        [0, 0],                         // Bottom Left (Back)
        [calculated_length, 0],         // Bottom Right (Front)
        [calculated_length, front_height_mm], // Top Right (Front Face)
        [0, back_height_mm]             // Top Left (Back Face)
    ]);
}

// --- DATA OUTPUT ---
echo("------------------------------------------------");
echo(str("Slope Angle: ", target_angle, " degrees"));
echo(str("Back Height: ", back_height_mm, " mm"));
echo(str("Front Height: ", front_height_mm, " mm"));
echo(str("Resulting Length: ", calculated_length, " mm"));
echo("------------------------------------------------");