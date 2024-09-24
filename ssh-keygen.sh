#!/bin/bash

read -p "Enter a comment for the SSH key: " comment

ssh-keygen -t ed25519 -C "$comment"
