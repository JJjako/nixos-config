#!/bin/sh

# take the first argument as the variable name
var="$1"

# indirect expansion to get its value
eval value=\$$var

notify-send "$var = $value"
