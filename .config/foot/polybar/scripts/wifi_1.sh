#!/bin/bash
watch -n1 "awk 'NR==3 {printf(\" %.0f%%\\n\",\$3*10/7)}' /proc/net/wireless"

