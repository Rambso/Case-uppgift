#!/bin/bash

mypath=$PATH

echo $mypath | sed "y/:/\\n/"
