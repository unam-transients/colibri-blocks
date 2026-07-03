rm -f 2010-mera-*.json

if test "$1" = "clean"
then
  exit
fi

while read blockidentifier alpha delta sky mag
do
  cat <<EOF >2010-mera-$blockidentifier.json
{
  "project": {
    "identifier": "2010",
    "name": "2010 FM40 Mera"
  },
  "identifier": "$blockidentifier",
  "name": "target $blockidentifier",
  "visits": [
    {
      "identifier": "0",
      "name": "photometry in g/zy",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "${alpha}d",
        "delta"  : "${delta}d",
        "equinox": "2000"
      },
      "command": "gridvisit 15 1 1 40 {{g zy}}",
      "estimatedduration": "3m"
    }
  ],
  "constraints": {
    "maxskybrightness": "$sky",
    "minzenithdistance": "10d",
    "maxairmass": "2.0",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF
    echo "    [ $alpha, $delta, \"2009-$blockidentifier Mera ($sky $mag)\", None, None, 10, 60, \"dashed\"],"
done <<EOF
00 102.022436 0.084417  bright 13.0
01 103.537926 2.030414  bright 15.6
02 103.745106 -3.700371 bright 10.0
03 104.283007 -10.28003 bright  8.3
04 104.693662 -7.362433 dark   18.7
05 105.050940 -9.021698 dark   18.7
06 207.554042 47.678242 bright  9.5
07 239.489542 29.166719 bright 12.2
08 253.330167 33.166147 bright 12.1
09 256.642042 20.134953 bright 12.8
10 271.029119 -27.33883 bright 13.0
11 279.310875 1.855750  gray   17.8   
12 279.900000 0.974861  dark   18.3   
13 280.093069 -2.633944 gray   16.4
14 280.959583 1.628167  gray   16.9   
15 281.043750 6.781953  dark   18.7
16 281.164708 4.405028  gray   17.2   
17 283.560625 3.984139  dark   18.7   
18 284.487542 -1.336500 dark   19.1   
19 285.678250 -3.616861 dark   18.5   
20 286.223792 3.034969  dark   20.1
21 286.953625 0.255722  gray   17.6   
22 287.596875 14.001111 gray   16.8   
23 287.634375 14.001333 dark   18.2
24 288.053625 13.507389 gray   17.4   
25 290.166000 6.706417  gray   18.0   
26 291.578042 11.383722 gray   17.9   
27 296.830500 30.300969 dark   18.7
28 318.539000 54.311642 gray   17.9
29 341.282417 63.303063 dark   19.3
EOF
