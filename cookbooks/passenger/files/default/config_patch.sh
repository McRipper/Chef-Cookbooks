#!/bin/sh

# Find our paths.
PASSENGER_ROOT=$(passenger-config --root)
RUBY_PATH=$(rbenv which ruby)

# Escape paths for passing into sed:
PASSENGER_ROOT=$(echo $PASSENGER_ROOT | sed -e 's/\([\/ ]\)/\\\1/g')
RUBY_PATH=$(echo $RUBY_PATH | sed -e 's/\([\/ ]\)/\\\1/g')

# Patch the config:
sed -e "s/##PASSENGER_ROOT##/${PASSENGER_ROOT}/g" -i $1
sed -e "s/##RUBY_PATH##/${RUBY_PATH}/g" -i $1
