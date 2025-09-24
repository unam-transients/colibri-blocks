#!/bin/sh

rm -f 0020-*

if test "$1" = "clean"
then
  exit
fi

while read block alpha delta
do
  cat <<EOF >0020-photometric-transformations-$block.json
{
  "project": {
    "identifier": "0020",
    "name": "photometric transformations"
  },
  "identifier": "$block",
  "name": "photometric transformations at $alpha $delta",
  "visits": [
    {
      "identifier": "0",
      "name": "objects",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "gridvisit 1 2 1 60 g/r/i/gri/B/z/y/zy",
      "estimatedduration": "12m"
    }
  ],
  "constraints": {
    "maxskybrightness": "bright",
    "maxairmass": "2.0",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF

done <<EOF
1 290.8684d -23.4694d
2 344.1933d -21.6598d
EOF

exit
