rm -f 1001-frb-250719a-*.json

if test "$1" = "clean"
then
  exit
fi

while read blockidentifier field alpha delta
do
    visitidentifier=0
    cat <<EOF >1001-frb-250719a-$blockidentifier-$visitidentifier.json
{
  "project": {
    "identifier": "1001",
    "name": "FRB 250719A -- field $field"
  },
  "identifier": "$blockidentifier",
  "name": "FRB 250719A -- field $field visit $visitidentifier",
  "visits": [
    {
      "identifier": "$visitidentifier",
      "name": "photometry in i",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "gridvisit 1 120 1 5 i",
      "estimatedduration": "160m"
    }
  ],
  "constraints": {
    "maxskybrightness": "astronomicaltwilight",
    "maxairmass": "2.0",
    "minmoondistance": "25d",
    "minha": "0h",
    "maxha": "+3.5h"
  },
  "persistent": "false"
}
EOF
done <<EOF
20250719034642 0    15:38:26.46 +69:21:23.8 
EOF
