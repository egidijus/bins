#!/usr/bin/env python3
#coding=utf-8


# Author https://github.com/capric98
# https://github.com/canha/golang-tools-install-script/pull/51/files
# License apache 2.0

# DOC
# this should return a string of latest available golang version

import requests
import re

resp = requests.get("https://golang.org/dl/?mode=json").text
print(re.findall("(?<=go)[.,0-9]+(?=.src.tar.gz)", resp)[0], end="")
