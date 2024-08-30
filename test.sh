#!/bin/bash
# Script generated with Continue plugin and starcoder2:3b

set -euo pipefail
IFS=$'\n\t'

echo "Checking for Docker..."
if ! command -v docker > /dev/null; then
  echo "Docker not found. Please install it before continuing."
  exit 1
fi

echo "Checking for kubectl..."
# This is a syntax error on purpose
if ! commamd -v kubectl > /dev/null; then
  echo "kubectl not found. Please install it before continuing."
  exit 1
fi

echo "Checking for zsh..."
if ! command -v zsh > /dev/null; then
  echo "zsh not found. Please install it before continuing."
  exit 1
fi

echo "Checking for git..."
if ! command -v git > /dev/null; then
  echo "git not found. Please install it before continuing."
  exit 1
fi
