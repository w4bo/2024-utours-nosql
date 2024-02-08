#!/bin/bash
set -exo
if test -f ".env"; then
    echo ".env already exists"
else
    cp .env.example .env
fi
docker compose build
npm install
