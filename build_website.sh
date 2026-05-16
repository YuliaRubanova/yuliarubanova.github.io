#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_BIN="${BUNDLE_BIN:-$HOME/.gem/ruby/2.6.0/bin/bundle}"
PREVIEW_PORT="${PREVIEW_PORT:-4177}"

cd "$ROOT_DIR"

usage() {
  cat <<USAGE
Usage:
  ./build_website.sh build      Build the Jekyll site into _site/
  ./build_website.sh preview    Build and serve _site/ at http://127.0.0.1:${PREVIEW_PORT}/
  ./build_website.sh publish    Build, commit the homepage changes, and push to origin master

Environment:
  BUNDLE_BIN     Path to bundle executable. Default: $BUNDLE_BIN
  PREVIEW_PORT   Preview server port. Default: $PREVIEW_PORT
USAGE
}

build() {
  "$BUNDLE_BIN" exec jekyll build
}

preview() {
  build
  cd "$ROOT_DIR/_site"
  python3 -m http.server "$PREVIEW_PORT"
}

publish() {
  build
  git status
  git add \
    _pages/about.md \
    _data/homepage.yml \
    _layouts/homepage.html \
    assets/css/homepage.css \
    assets/pdf/Yulia_Rubanova_CV_2025.pdf \
    assets/img/veo_3_1_ingredients_to_video.png \
    assets/img/publication_preview/trajan_good.gif \
    assets/img/publication_preview/gemini_robotics_1_5_title.png
  git commit -m "Redesign homepage"
  git push origin master
}

case "${1:-build}" in
  build)
    build
    ;;
  preview)
    preview
    ;;
  publish)
    publish
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage
    exit 1
    ;;
esac
