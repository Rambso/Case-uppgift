#!/bin/bash

wc < /var/log/* 1> output.log

wc < /var/log/* 2> error.log

echo Output:
cat output.log

echo Errors:
cat error.log
