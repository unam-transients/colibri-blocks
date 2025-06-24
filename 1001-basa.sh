rm -f 1001-basa-*.json 1001-basa-*.reg

if test "$1" = "clean"
then
  exit
fi

while read blockidentifier field alpha delta
do
    visitidentifier=0
    #echo >1001-basa-$blockidentifier.reg J2000
    cat <<EOF >1001-basa-$blockidentifier-$visitidentifier.json
{
  "project": {
    "identifier": "1001",
    "name": "TDEs - Basa"
  },
  "identifier": "$blockidentifier",
  "name": "$field visit $visitidentifier",
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
      "command": "gridvisit 1 5 1 60 g/r 5am",
      "estimatedduration": "12m"
    }
  ],
  "constraints": {
    "maxskybrightness": "bright",
    "maxairmass": "1.6",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF
done <<EOF
1 COMA1    13:00:34.447    +28:05:32.05
2 COMA2    13:00:33.807    +27:49:27.26
3 COMA3    12:58:28.763    +28:05:23.51
4 COMA4    12:59:09.138    +27:49:27.13
EOF
