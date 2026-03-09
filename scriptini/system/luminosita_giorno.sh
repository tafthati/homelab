#!/bin/bash

#Ripristina il valore originale della luminosità
echo 937 | sudo tee /sys/class/backlight/intel_backlight/brightness
