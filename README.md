# Kabisa code style

In this repository we track the configuration of our code style linting tools. Configuration is provided for:

- [ESLint](https://eslint.org/)
- [Markdown lint](https://github.com/markdownlint/markdownlint)
- [Rubocop](http://batsov.com/rubocop/)
- [Reek](https://github.com/troessner/reek)

A [`.codeclimate.yml` configuration file](https://docs.codeclimate.com/docs/advanced-configuration) 
is provided to be able to monitor the project's code quality using
[Code Climate](https://codeclimate.com).

For more information about using and configuring Code Climate, please refer to their 
[documentation](https://docs.codeclimate.com/docs). 

## Install styleguids

In the repository where you want the styleguides run:

```bash
curl -sSL https://raw.githubusercontent.com/kabisa/code-style/master/install.sh | bash
```

The installer will try to detect which files should be installed.

Example output:

    Copying config for Codeclimate
      ✔ Copied .codeclimate.yml
    Detected Gemfile.
      ✔ Copied .rubocop.yml
      ✔ Copied config.reek
      ✔ Enabled 'bundler-audit' plugin.
      ✔ Enabled 'rubocop' plugin.
      ✔ Enabled 'reek' plugin.
    Detected markdown files.
      ✔ Copied .mdlrc
      ✔ Enabled 'markdownlint' plugin.
    Detected CSS files.
      ✔ Enabled 'csslint' plugin.
    Detected SASS/SCSS files.
      ✔ Enabled 'scss-lint' plugin.

## Install CodeClimate CLI

### OSX

    brew tap codeclimate/formulae
    brew install codeclimate
    
### Anywhere

    curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz
    cd codeclimate-* && sudo make install
    
## Run CodeClimate CLI

    codeclimate analyze

For more information about the Code Climate CLI, please refer to 
[github.com/codeclimate/codeclimate](https://github.com/codeclimate/codeclimate).
