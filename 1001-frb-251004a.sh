rm -f 1001-frb-251004a-*.json

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
    "name": "FRB 251004A -- field $field"
  },
  "identifier": "$blockidentifier",
  "name": "FRB 251004A -- field $field visit $visitidentifier",
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
      "command": "dithervisit 24 {5 5 5 5 5} {i i i i i}",
      "estimatedduration": "12m"
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
20251004022235 0    19:15:46.66 +53:40:25.0 
EOF
