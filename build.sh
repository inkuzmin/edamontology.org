#! /bin/bash

set -ev

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
    bundle install
    bundle exec jekyll build

    if [ "$TRAVIS_BRANCH" = "master" ]; then
        git clone --branch gh-pages https://${GH_TOKEN}@github.com/$TRAVIS_REPO_SLUG.git ./output
        cd output
    fi

    rm -rf ./*
    mv ../_site/* .
    git add .
    git commit -m "build ${TRAVIS_BUILD_NUMBER}" || true
    git push --quiet origin gh-pages || true
fi
