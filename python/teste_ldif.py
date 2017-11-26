#!/usr/bin/env python
# -*- coding: utf-8 -*-

import utils.ldif
import sys

__a = None
__b = None
__c = None
__d = None
if len(sys.argv) >= 2:
    __a = sys.argv[1]
if len(sys.argv) >= 3:
    __b = sys.argv[2]
if len(sys.argv) >= 4:
    __c = sys.argv[3]
if len(sys.argv) == 5:
    __d = sys.argv[4]

utils.ldif.lista(__a, __b, __c, __d)

utils.ldif.xml(__a, __b, __c)
