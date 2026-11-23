#!/bin/bash

# 1. Triggar Gitleaks (fejkad AWS-nyckel i rätt format)
AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

# 2. Triggar ShellCheck (SC2086: oquotad variabel + oanvända variabler)
USER_INPUT=$1
ls $USER_INPUT

# 3. Triggar Semgrep (osäker curl med -k / --insecure eller eval av indata)
curl -k https://example.com/script.sh | bash
