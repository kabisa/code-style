#!/usr/bin/env bash

temp_dir=/tmp/kabisa_code_style

git clone --quiet --depth=1 git@github.com:kabisa/code-style.git ${temp_dir}

echo "Copying config for Codeclimate"
cp ${temp_dir}/.codeclimate.yml .

if [ -f Gemfile ]; then
  echo "Detected Gemfile. Copying config for Rubocop and Reek."
  cp ${temp_dir}/.rubocop.yml .
  cp ${temp_dir}/config.reek .
fi

if [ -f package.json ]; then
  echo "Detected package.json. Copying config for ESLint."
  cp ${temp_dir}/.eslintrc.json .
fi

markdown_files=(`find .  -name "*.md" | grep -v /node_modules/`)

if [ ${#markdown_files[@]} -gt 0 ]; then
  echo "Detected markdown files. Copying config for MarkdownLint."
  cp ${temp_dir}/.mdlrc .
fi

rm -rf ${temp_dir}
