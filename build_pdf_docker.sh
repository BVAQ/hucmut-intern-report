#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo "Updating apt..."
apt-get update -qq

echo "Installing dependencies (this will take a few minutes)..."
apt-get install -y -qq \
  pandoc \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-lang-other \
  latexmk \
  python3 \
  python3-yaml

echo "Converting Hugo to LaTeX..."
python3 scripts/convert_hugo_to_latex.py

echo "Compiling Vietnamese PDF..."
cd report
latexmk -pdf -interaction=nonstopmode main.tex
cp main.pdf ../report_vn.pdf

echo "Compiling English PDF..."
latexmk -pdf -interaction=nonstopmode main_en.tex
cp main_en.pdf ../report_en.pdf

echo "Done! PDFs are generated successfully."
