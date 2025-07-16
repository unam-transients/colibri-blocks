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
5 Abell1   16:29:06.26     +39:25:48.8
6 Abell2   16:27:57.85     +39:38:16.8
7 Abell3   16:29:06.34     +39:38:12.7
8 Abell4   16:27:57.60     +39:25:48.6
9  Perseus1 3:20:26.069    +41:38:38.35
10 Perseus2 3:20:25.912    +41:22:55.15
11 Perseus3 3:19:12.201    +41:38:45.62
12 Perseus4 3:19:11.704    +41:22:55.22
EOF
