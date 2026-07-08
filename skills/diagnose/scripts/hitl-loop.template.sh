#!/usr/bin/env bash
# Human-in-the-loop diagnosis loop (last resort).
# Use when reproducing the bug requires a human action (a click, a device, a manual step)
# that the agent cannot automate. Keeps the debugging loop structured: the human performs
# the action, the script captures the signal, and the output feeds back to the agent.
#
# Fill in the two functions below, then run:  bash hitl-loop.template.sh
set -euo pipefail

ITER=0

# What the human must do each iteration. Keep it to one clear instruction.
prompt_human() {
  echo ">>> [iter $ITER] Do the action now, then press Enter to capture the signal."
  read -r _
}

# How the signal is captured. Replace with the real command(s): curl, log tail, screenshot,
# reading a status file, etc. Print PASS or FAIL so the agent can read the result.
capture_signal() {
  # Example: check a health endpoint / grep a log / diff an output.
  # if curl -sf localhost:3000/debug/state | grep -q "expected"; then echo PASS; else echo FAIL; fi
  echo "REPLACE_ME: capture the pass/fail signal here"
}

while true; do
  ITER=$((ITER + 1))
  prompt_human
  echo "--- signal (iter $ITER) ---"
  capture_signal
  echo "---------------------------"
  echo "Continue? [y/N]"
  read -r ans
  [[ "${ans:-N}" == "y" ]] || break
done
