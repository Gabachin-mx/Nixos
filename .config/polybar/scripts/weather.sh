#!/usr/bin/env bash

command -v jq >/dev/null 2>&1 || { echo >&2 "Program 'jq' required but it is not installed.  Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "Program 'wget' required but is not installed.  Aborting."; exit 1; }

APIKEY="44f64d628a1408d354d987005f236f23"
#ZIPCODE="3530597"
#ZIPCODE="04310"
#URL="http://api.openweathermap.org/data/2.5/weather?zip=${ZIPCODE},{MX}&units=imperial&APPID=${APIKEY}"

URL="http://api.openweathermap.org/data/2.5/weather?id=3530597&APPID=${APIKEY}&units=metric"

WEATHER_RESPONSE=$(wget -qO- "${URL}")

WEATHER_CONDITION=$(echo $WEATHER_RESPONSE | jq '.weather[0].main' | sed 's/"//g')
WEATHER_TEMP=$(echo $WEATHER_RESPONSE | jq '.main.temp' | awk '{print int($0)}')

case $WEATHER_CONDITION in
  'Clouds')
    WEATHER_ICON=""
    ;;
  'Rain')
    WEATHER_ICON=""
    ;;
  'Snow')
    WEATHER_ICON=""
    ;;
  *)
    WEATHER_ICON=""
    ;;
esac

echo -e "${WEATHER_ICON} ${WEATHER_TEMP}°C"
