#!/bin/sh

sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' ~/.ssh/config | grep -v "*"
