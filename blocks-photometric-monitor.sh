#!/bin/sh

rm -f 0005-*

if test "$1" = "clean"
then
  exit
fi

for ra in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
do
  cat <<EOF >0005-photometric-monitor-0$ra.json
{
  "project": {
    "identifier": "0005",
    "name": "photometric monitors"
  },
  "identifier": "0$ra",
  "name": "photometric monitor in g/r/i/gri/B/z/y/zy near ${suffix}h +45d",
  "visits": [
    {
      "identifier": "0",
      "name": "objects",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "${ra}h",
        "delta"  : "+45d",
        "equinox": "2000"
      },
      "command": "gridvisit 1 1 1 60 g/r/i/gri/B/z/y/zy",
      "estimatedduration": "6m"
    }
  ],
  "constraints": {
    "maxskybrightness": "bright",
    "minairmass": "1.2",
    "maxairmass": "1.3",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF

done

exit
