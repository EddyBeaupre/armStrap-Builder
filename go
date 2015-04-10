#!/bin/bash

./configure --host=arm-linux-gnueabihf --prefix=/usr MAKE_PARAMS=-j24
make
