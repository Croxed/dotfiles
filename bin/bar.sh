#! /usr/local/bin/bash

#Helper functions
terminal_width(){
  local width_height=`stty size`
  echo "${width_height/* /}"
}
string_times_n(){
  local s=$1
  local n=$2
  for i in $n; 
    do echo -n "$s"
  done
}
##The actual function
bar(){
  local percentage=$1
  local padding=10
  local width=$(echo "scale=0; 0.5 * $(terminal_width)" | bc | cut -d. -f1)
  local equals_n=$(echo "$percentage * $width / 100" | bc | cut -d. -f1)
  local dots_n=$((width - equals_n))

  #ANSI escape sequence magic
  local Esc="\033["
  local up="$Esc""K""$Esc""1A""$Esc""K"

  #Clear the line
  string_times_n ' ' "$width"
  echo -ne "\r"

  #Print the current screen
  printf  "%3s%% [" "$percentage"
  string_times_n '=' "$equals_n"
  string_times_n '.' "$dots_n"
  echo -n "]"

  #Go up unless finished
  if [[ "$percentage" == 100 ]] 
  then
    echo
  else
    echo -e "$up"
  fi
}
