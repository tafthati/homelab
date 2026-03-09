#|/bin/bash

# Regola la luminosità ideale per fare le ninne
echo 10 | sudo tee /sys/class/backlight/intel_backlight/brightness
