arch=$(uname -m)
if [[ "$OSTYPE" == darwin* ]]; then
    if [[ "$arch" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ "$arch" == "x86_64" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
