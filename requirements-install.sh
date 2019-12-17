#!/bin/bash 

VENDOR_DIR="vendor/"

if [ -d "$VENDOR_DIR" ]; then
    echo "Vendor dir is exsist. Skip."
    exit 1
fi

mkdir -p "$VENDOR_DIR"

luarocks install --tree="$VENDOR_DIR" luaunit