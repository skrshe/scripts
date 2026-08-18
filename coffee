#!/bin/env bash
waketime="${1:-2h}"
echo wake for $waketime
caffeinate sleep $waketime

