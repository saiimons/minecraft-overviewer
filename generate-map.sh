#!/bin/bash
ACTIVE_GENERATION_FLAG="/home/minecraft/generate";

if [ -f $ACTIVE_GENERATION_FLAG ]; then
  echo "Map generation is already running..."
else
  echo "generating..." >> $ACTIVE_GENERATION_FLAG

  # Run the world renders (One pass to make map, one to generate points of interests)
  overviewer.py --config /home/minecraft/config.py

  grep "?key=" /home/minecraft/render/index.html
  if [ $? != 0 ]; then
    sed -i "s|https://maps.google.com/maps/api/js|&?key=${GOOGLE_MAPS_API_KEY}|g" /home/minecraft/render/index.html
  fi

  rm -rf $ACTIVE_GENERATION_FLAG
fi
