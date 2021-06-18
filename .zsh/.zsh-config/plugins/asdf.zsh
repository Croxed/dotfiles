#! /usr/bin/env zsh

_install_and_source_asdf() {
    if [ ! -d "$HOME"/.asdf ]; then
        git clone https://github.com/asdf-vm/asdf.git "$HOME"/.asdf &>/dev/null
        git -C "$HOME"/.asdf checkout "$(git -c "$HOME"/.asdf describe --abbrev=0 --tags)"
    fi
    source "$HOME"/.asdf/asdf.sh
    fpath=(${ASDF_DIR}/completions $fpath)
}

_install_asdf_plugin_if_not_installed() {
    local installed_plugins required_plugins
    installed_plugins=("${(@f)$(asdf plugin list)}")
    for plugin ($required_plugins); do
        if (($installed_plugins[(Ie)$plugin])); then
            continue
        fi
        
        asdf plugin add $plugin &>/dev/null
    done

}

_install_and_source_asdf
_install_asdf_plugin_if_not_installed
