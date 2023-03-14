#!/bin/sh

rm -f 0008-pointing-map-*.json

if test "$1" = "clean"
then
  exit
fi

awk '
BEGIN {
  pi = 4 * atan2(1, 1);
}
function degtorad(x) {
  return x * pi / 180;
}
function radtodeg(x) {
  return x * 180 / pi;
}
function asin(x) {
 return atan2(x, sqrt(1-x*x));
}
function acos(x) {
  return atan2(sqrt(1-x*x), x);
}
function atan(x) {
  return atan2(x,1);
}
function zenithdistance(ha, delta) {
  ha = degtorad(ha);
  delta = degtorad(delta);
  latitude = degtorad(31);
  z = acos(sin(latitude) * sin(delta) + cos(latitude) * cos(delta) * cos(ha));
  return radtodeg(z);
}
BEGIN {
  dha = 15;
  ddelta = 15;
  blockid = 0;
  iha = 0;
  for (ha = -180 + 0.5 * dha; ha < 180; ha += dha) {
    startdelta = -20;
    if (iha % 2 == 1) 
      startdelta += 0.5 * ddelta;
    iha += 1;
    for (delta = startdelta; delta < 90; delta += ddelta) {
      z = zenithdistance(ha, delta)
      if (5 <= z && z <= 60)
        printf("%04d %+.1fd %+.1fd %.1fd\n", blockid++, ha, delta, z);
    }
  }
}
' |
while read blockid ha delta z
do
    cat >0008-pointing-map-$blockid.json <<EOF
{
  "project": {
    "identifier": "0008",
    "name": "pointing map"
  },
  "identifier": "$blockid",
  "name": "pointing map at $ha $delta",
  "visits": [
    {
      "identifier": "0",
      "name": "pointing map",
      "targetcoordinates": {
        "type"   : "equatorial",
        "ha"     : "$ha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "pointingmapvisit",
      "estimatedduration": "1m"
    }
  ],
  "constraints": {
    "maxfocusdelay": "21600",
    "maxskybrightness": "astronomicaltwilight"
  }
}
EOF
done
