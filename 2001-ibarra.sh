rm -f 2001-ibarra-*.json 2001-ibarra-*.reg

if test "$1" = "clean"
then
  exit
fi

while read blockidentifier field alpha0 delta0
do
    #echo >2001-ibarra-$blockidentifier.reg J2000
    awk -v alpha0=$alpha0 -v delta0=$delta0 '
        BEGIN {
            pi = 4.0 * atan2(1, 1)
        }
        function cosd(x) {
            return cos(x * pi / 180)
        }
        BEGIN {
            for (i = 0; i <= 5; ++i) {
                for (j = 0; j <= 5; ++j) {
                    delta = delta0 + (j - 2.5) * 25 / 60
                    alpha = alpha0 + (2.5 - i) * 25 / 60 / cosd(delta)
                    printf("%01d%01d %.5fd %.4fd\n", i, j, alpha, delta)
                }
            }
        }
    ' /dev/null |
    while read visitidentifier alpha delta
    do
        #echo >>2001-ibarra-$blockidentifier.reg box $alpha $delta 0.427d 0.427d
        cat <<EOF >2001-ibarra-$blockidentifier-$visitidentifier.json
{
  "project": {
    "identifier": "2001",
    "name": "SDSS-V Reververation Mapping AGN with COLIBRI - Ibarra"
  },
  "identifier": "$blockidentifier",
  "name": "$field visit $visitidentifier",
  "visits": [
    {
      "identifier": "$visitidentifier",
      "name": "photometry in g/r/i/z/y",
      "targetcoordinates": {
        "type"   : "equatorial",
        "alpha"  : "$alpha",
        "delta"  : "$delta",
        "equinox": "2000"
      },
      "command": "gridvisit 1 1 1 30 {{g y} {r y} {i z}}",
      "estimatedduration": "3m"
    }
  ],
  "constraints": {
    "maxskybrightness": "bright",
    "minzenithdistance": "10d",
    "maxairmass": "2.0",
    "minmoondistance": "15d"
  },
  "persistent": "false"
}
EOF
    done
done <<EOF
1 RM1 214.18 +53.24
2 RM2 150.31  +2.40
3 RM3  36.44  -4.58
EOF
