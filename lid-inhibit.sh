#!/bin/bash
# A script to inhibit the lid switch for 30 seconds.
# Useful when docking and undocking a laptop in a vertical dock.

notify-send "Inhibiting lid-switch for 30 seconds"
systemd-inhibit --what handle-lid-switch --why "Laptop docking/undocking" --mode block sleep 30
