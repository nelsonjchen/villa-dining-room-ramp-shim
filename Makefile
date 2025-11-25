# Makefile for ramp_shim

SCAD_FILE = ramp_shim.scad
DINING_STL = ramp_shim_dining.stl
LIVING_STL = ramp_shim_living.stl
IMG_SIZE  = 800,600

all: $(DINING_STL) $(LIVING_STL)

$(DINING_STL): $(SCAD_FILE)
	openscad -o $@ -D is_dining_room=true $<

$(LIVING_STL): $(SCAD_FILE)
	openscad -o $@ -D is_dining_room=false $<

clean:
	rm -f $(DINING_STL) $(LIVING_STL) *.png

.PHONY: all clean
