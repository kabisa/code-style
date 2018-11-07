#!/usr/bin/env bash

temp_dir=/tmp/kabisa_code_style
check_mark=$'\xE2\x9C\x94'
cross=$'\xE2\x9C\x97'

enable_plugin() {
  rubies=(`which ruby`)

  if [ ${#rubies[@]} -gt 0 ]; then
    cmd='puts STDIN.read.gsub(/(#{ARGV[0]}:)([ \n]+)(enabled:)([ \n]+)(true|false)/) { %Q[#{$1}#{$2}#{$3}#{$4}true] }'
    current_file=`cat .codeclimate.yml`
    echo "${current_file}" | ruby -e "${cmd}" "${1}" > .codeclimate.yml
    echo "  ${check_mark} Enabled '${1}' plugin."
  else
    echo "  ${cross} Could not find ruby interpreter. Please enable '${1}' plugin yourself."
  fi
}

copy_file() {
  cp ${temp_dir}/${1} .
  echo "  ${check_mark} Copied ${1}"
}

git clone --quiet --depth=1 git@github.com:kabisa/code-style.git ${temp_dir}

echo "Copying config for Codeclimate"
copy_file ".codeclimate.yml"

if [ -f Gemfile ]; then
  echo "Detected Gemfile."
  copy_file ".rubocop.yml"
  copy_file "config.reek"
  enable_plugin "bundler-audit"
  enable_plugin "rubocop"
  enable_plugin "reek"
fi

if [ -f package.json ]; then
  echo "Detected package.json."
  copy_file ".eslintrc.json"
  enable_plugin "eslint"
  enable_plugin "nodesecurity"
fi

markdown_files=(`find . -type f -name "*.md" | grep -v /node_modules/`)

if [ ${#markdown_files[@]} -gt 0 ]; then
  echo "Detected markdown files."
  copy_file ".mdlrc"
  enable_plugin "markdownlint"
fi

rails_gems=(`bundle list | grep rails`)

if [ ${#rails_gems[@]} -gt 0 ]; then
  echo "Detected Rails."
  enable_plugin "brakeman"
fi

css_files=(`find . -type f -name "*.css" | grep -v /node_modules/`)

if [ ${#css_files[@]} -gt 0 ]; then
  echo "Detected CSS files."
  enable_plugin "csslint"
fi

sass_files=(`find . -type f \( -name "*.sass" -or -name "*.scss" \) | grep -v /node_modules/`)

if [ ${#css_files[@]} -gt 0 ]; then
  echo "Detected SASS/SCSS files."
  enable_plugin "scss-lint"
fi

rm -rf ${temp_dir}
