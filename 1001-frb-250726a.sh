rm -f 1001-frb-250726a-*.json

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
    "name": "FRB 250726A -- field $field"
  },
  "identifier": "$blockidentifier",
  "name": "FRB 250726A -- field $field visit $visitidentifier",
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
      "command": "dithervisit 48 {5 5 5 5 5} {i i i i i}",
      "estimatedduration": "24m"
    }
  ],
  "constraints": {
    "maxskybrightness": "astronomicaltwilight",
    "maxairmass": "2.0",
    "minmoondistance": "25d",
    "minha": "-2.0h",
    "maxha": "0h"
  },
  "persistent": "false"
}
EOF
done <<EOF
20250726131042 0    01:30:25.03 +63:02:15.36
EOF
