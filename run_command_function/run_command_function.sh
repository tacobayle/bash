#!/bin/bash
run_cmd() {
  if eval "$@"; then
   echo "it worked"
  else
   echo "it did not work"
  fi
}
run_cmd 'lst -al'
