#!/bin/bash

read -p "Enter a comment for the SSH key: " comment

ssh-keygen -t rsa -b 4096 -C "$comment"
