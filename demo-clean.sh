#!/usr/bin/env bash

git remote remove deis
deis destroy -a otto-getting-started --confirm=otto-getting-started
deis auth:cancel --username=test --password=asdf1234 --yes
