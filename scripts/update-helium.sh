#!/usr/bin/env nix-shell
#!nix-shell -p gh jq -i bash

echo ">>> checking latest version of Helium Browser"

# read -d '' LATEST_VERSION GH_CHECKSUM < <(gh api repos/imputnet/helium-linux/releases/latest | jq -r '.tag_name, (.assets[] | select(type == "object") | select(.name and .content_type and (.name | contains("x86_64")) and (.content_type | contains("application/x-xz"))) | .digest)')

LATEST_VERSION=$(gh api repos/imputnet/helium-linux/releases/latest | jq -r .tag_name)

echo ">>> latest version is: $LATEST_VERSION"

CURRENT_VERSION=$(/usr/local/bin/helium --version | awk '{print $2}')

echo ">>> current version is: $CURRENT_VERSION"

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
  echo ">>> no update required"
  if [ ! "$1" = "--force" ]; then
    exit 0
  fi
fi

VERSION="$LATEST_VERSION"

FILE="helium-latest.tar.xz"
EXTRACTED_DIR="helium-linux"

gh release download -R imputnet/helium-linux -p "helium-*-x86_64_linux.tar.xz" --output $FILE
gh release download -R imputnet/helium-linux -p "helium-*-x86_64_linux.tar.xz.asc" --output $FILE.asc

echo "verifying signature..."

FINGERPRINT="BE677C1989D35EAB2C5F26C9351601AD01D6378E"
gpg --list-keys "$FINGERPRINT" >/dev/null 2>&1 || gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys "$FINGERPRINT"

if gpg --verify "$FILE.asc" "$FILE"; then
    echo ">>> verification passed"
    echo ">>> extracting $FILE"

    if [ ! -d $EXTRACTED_DIR ]; then
        mkdir $EXTRACTED_DIR
        tar -xf helium-latest.tar.xz --strip-components=1 -C $EXTRACTED_DIR
    else
        echo "$EXTRACTED_DIR dir exists!"
    fi

    echo "authentication to install:"
    doas true || exit 1

    if [ -d "/opt/helium-linux" ]; then
        doas rm -rf /opt/helium-linux
    fi

    doas mv "$EXTRACTED_DIR" /opt/helium-linux

    doas ln -sf /opt/helium-linux/helium /usr/local/bin/helium
    doas ln -sf /opt/helium-linux/helium.desktop /usr/local/share/applications/helium.desktop
    doas ln -sf /opt/helium-linux/product_logo_256.png /usr/share/icons/helium.png
    rm -fr $FILE $FILE.asc
else
    echo ">>> verification failed"
    exit 1
fi

exit 0
