if [ ! -d "$HOME"/.phpenv ]; then
    git clone "https://github.com/phpenv/phpenv.git" "$HOME"/.phpenv &>/dev/null
fi

if [ ! -d "$HOME"/.phpenv/plugins/php-build ]; then
    git clone "https://github.com/php-build/php-build" "$HOME"/.phpenv/plugins/php-build &>/dev/null
fi

phpenv() {
    if ! command -v phpenv &>/dev/null; then
        eval "$(phpenv init -)"
    fi

    command phpenv "$@"
}