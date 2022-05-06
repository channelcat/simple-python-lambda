#!/bin/bash

killall -9 node >/dev/null 2>&1
killall -9 serverless >/dev/null 2>&1
serverless offline --host 0.0.0.0&