#!/bin/bash

if [[ ! -d '/app/venv' ]]; then
  cd .devcontainer/spec-kit/
  echo "Installing dependencies..."
  uv python install && uv sync --frozen
else
  echo "Virtual environment already exists."
fi
