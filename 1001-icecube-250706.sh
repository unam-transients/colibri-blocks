rm -f 1001-icecube-250706-*.json

if test "$1" = "clean"
then
  exit
fi

while read blockidentifier field alpha delta
do
    visitidentifier=0
    cat <<EOF >1001-icecube-250706-$blockidentifier-$visitidentifier.json
{
  "project": {
    "identifier": "1001",
    "name": "IceCube 250706 -- field $field"
  },
  "identifier": "$blockidentifier",
  "name": "IceCube 250706 -- field $field visit $visitidentifier",
  "visits": [
    {
      "identifier": "$visitidentifier",
      "name": "photometry in r",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "gridvisit 1 4 1 60 i",
      "estimatedduration": "5m"
    }
  ],
  "constraints": {
    "maxskybrightness": "astronomicaltwilight",
    "maxairmass": "2.0",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF
done <<EOF
20250706131440 0    17:43:12.00	+38:46:11.6
20250706131640 1    17:43:12.00	+39:10:12.0
20250706131840 2    17:44:48.00	+39:10:12.0
20250706132040 3    17:44:48.00	+38:46:12.0	
EOF
