#!/bin/bash
w_xml=$(curl --silent "http://weather.tuxnet24.de/?id=12886743&mode=xml");
w_txt=$(xmllint --xpath "string(//current_text)" - <<<"$w_xml" | xargs);
w_tpc=$(xmllint --xpath "string(//current_temp)"  - <<<"$w_xml" | xargs); w_tpc=${w_tpc//[[:blank:]]/};

if   [ "$w_txt" == "Sunny" ]; then w_sym="☼";
elif [ "$w_txt" == "Mostly Sunny" ]; then w_sym="☼";
elif [ "$w_txt" == "Showers" ]; then w_sym="☂";
elif [ "$w_txt" == "Scattered Showers" ]; then w_sym="☂";
elif [ "$w_txt" == "Clear" ]; then w_sym="☾";
elif [ "$w_txt" == "Thunderstorms" ]; then w_sym="⚡";
elif [ "$w_txt" == "Scattered Thunderstorms" ]; then w_sym="☔";
elif [ "$w_txt" == "Isolated Thundershovers" ]; then w_sym="☔";
elif [ "$w_txt" == "Cloudy" ]; then w_sym="☁";
elif [ "$w_txt" == "Mostly Cloudy" ]; then w_sym="☁";
elif [ "$w_txt" == "Partly Cloudy" ]; then w_sym="☼☁";
elif [ "$w_txt" == "Breezy" ]; then w_sym="⚐";
else w_sym=$w_txt; 
fi
echo "$w_sym"" ""$w_tpc";
