#!/usr/bin/env bash

set -eo pipefail -o nounset

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

echo -e "${bldblu}Generating discovery-url...${txtrst}"

export GOPATH="${HOME}/go"
(
  cd ${GOPATH}/src/github.com/deis/deis
  make discovery-url
)

ssh-add ~/.ssh/deis-test

echo -e "${bldblu}Exporting DO_TOKEN + DO_SSH_FINGERPRINT...${txtrst}"

export DO_TOKEN="$(cat ~/.ssh/do-token | head -n1)"
export DO_SSH_FINGERPRINT="$(cat ~/.ssh/do-token | tail -n1)"

echo -e "${bldblu}Running ${bldwht}otto infra${bldblu}...${txtrst}"

otto infra
