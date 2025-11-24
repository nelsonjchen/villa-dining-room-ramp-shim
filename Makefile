# Makefile for ramp_shim

# --- Variables ---
SCAD_FILE = ramp_shim.scad
DXF_FILE = ramp_shim.dxf
PNG_FILE = ramp_shim.png

# --- Targets ---

all: dxf png

dxf: $(DXF_FILE)

png: $(PNG_FILE)

$(DXF_FILE): $(SCAD_FILE)
	openscad -o $@ -D output_2D=true $<

$(PNG_FILE): $(SCAD_FILE)
	openscad -o $@ -D output_2D=false $<

clean:
	rm -f $(DXF_FILE) $(PNG_FILE)

.PHONY: all dxf png clean
