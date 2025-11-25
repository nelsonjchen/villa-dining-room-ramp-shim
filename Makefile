# Makefile for ramp_shim

SCAD_FILE = ramp_shim.scad
STL_FILE  = ramp_shim.stl
PNG_FILE  = ramp_shim.png
IMG_SIZE  = 800,600

all: stl png

stl: $(STL_FILE)
png: $(PNG_FILE)

$(STL_FILE): $(SCAD_FILE)
	openscad -o $@ $<

$(PNG_FILE): $(SCAD_FILE)
	openscad -o $@ $< --imgsize=$(IMG_SIZE)

clean:
	rm -f $(STL_FILE) $(PNG_FILE)

.PHONY: all stl png clean
