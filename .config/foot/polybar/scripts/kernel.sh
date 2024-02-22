#!/bin/sh

echo $(uname -r) | awk '{print $0}'
