#
# Zim initializition
#

# Define zim location
ZIM="${ZDOTDIR:-${HOME}}/.zim"

# Source user configuration
if [[ -s "${ZDOTDIR:-${HOME}}/.zimrc" ]]; then
  source "${ZDOTDIR:-${HOME}}/.zimrc"
fi

load_zim_module() {
  local wanted_module

  for wanted_module (${zmodules}); do
    if [[ -s "${ZIM}/modules/${wanted_module}/init.zsh" ]]; then
      source "${ZIM}/modules/${wanted_module}/init.zsh"
    elif [[ ! -d "${ZIM}/modules/${wanted_module}" ]]; then
      print "No such module \"${wanted_module}\"." >&2
    fi
  done
}

load_zim_function() {
  local function_glob='^([_.]*|prompt_*_setup|README*)(-.N:t)'
  local mod_function

  # autoload searches fpath for function locations; add enabled module function paths
  fpath=(${${zmodules}:+${ZIM}/modules/${^zmodules}/functions(/FN)} ${fpath})

  function {
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    for mod_function in ${ZIM}/modules/${^zmodules}/functions/${~function_glob}; do
      autoload -Uz ${mod_function}
    done
  }
}

# initialize zim modules
load_zim_function
load_zim_module

unset zmodules
unfunction load_zim_{module,function}
