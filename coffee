#!/bin/env bash
waketime="${2:-2h}"
echo wake for $waketime
caffeinate sleep $waketime

