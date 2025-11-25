# Villa Dining Room Ramp Shim

This project contains a parametric OpenSCAD script for generating a 3D-printable ramp shim. It is designed to bridge the height difference between floor levels, specifically tailored for a dining room or living room transition.

## Features

-   **Parametric Design:** Easily adjustable dimensions via variables at the top of the `.scad` file.
-   **Configurable Profiles:** Includes a toggle (`is_dining_room`) to switch between preset heights for different rooms.
-   **Hollow Structure:** Generates a hollow shell with a specified wall thickness to save material while maintaining structural integrity.
-   **Overhang Lip:** Optional rectangular extension to help the ramp sit flush or hook onto surfaces.
-   **Floor Cut:** Automatically slices the bottom to ensure a flat base.

## Configuration

Open `ramp_shim.scad` in OpenSCAD or a text editor to modify the following parameters:

-   `is_dining_room`: Set to `true` for dining room height (10.3mm) or `false` for living room height (18.0mm).
-   `back_height_mm`: Height of the back of the ramp.
-   `block_width_mm`: Width of the ramp block.
-   `overhang_length_mm` & `lip_thickness_mm`: Dimensions for the front lip extension.
-   `wall_thickness`: Thickness of the printed walls.

## Prerequisites

-   [OpenSCAD](https://openscad.org/) must be installed and available in your system path.

## Building

A `Makefile` is provided to automate the generation of STL files and preview images.

To generate the STL file for 3D printing:

```bash
make stl
```

To generate a PNG preview image:

```bash
make png
```

To generate both:

```bash
make all
```

To clean up generated files:

```bash
make clean