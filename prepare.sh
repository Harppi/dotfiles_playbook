#!/bin/bash

# Exit on error
set -e

main() {
  # Install Apple's command line tools
  install_command_line_tools
  # Install Homebrew
  install_homebrew
  # Install Ansible
  brew_install
  # Install dotfiles Ansible role
  install_dotfiles_role
}

DOTFILES_REPO=~/Documents/dotfiles

function install_command_line_tools() {
  info "Installing Apple's command line tools..."
  if xcode-select --install; then
    success "Apple's command line tools installation succeeded."
  else
    if xcode-select -p; then
      success "Apple's command line tools are already installed."
    else
      error "Apples's command line tools installation failed."
      exit 1
    fi
  fi
}

function install_homebrew() {
  info "Installing Homebrew..."
  if hash brew 2>/dev/null; then
    success "Homebrew already exists."
  else
    url=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    substep "Running Homebrew installation script..."
    if /bin/bash -c "$(curl -fsSL ${url})"; then
      success "Running Homebrew installation script succeeded."
    else
      error "Running Homebrew installation script failed."
      exit 1
    fi
    substep "Adding Homebrew to PATH..."
    if echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' \
      >> /Users/$(whoami)/.zprofile && \
      eval "$(/opt/homebrew/bin/brew/shellenv)"; then
      success "Adding Homebrew to PATH succeeded."
    else
      error "Adding Homebrew to PATH failed."
      exit 1
    fi
  fi
}

function brew_install() {
  package_to_install="ansible"
  info "brew install ${package_to_install}"
  if hash "$package_to_install" 2>/dev/null; then
    success "${package_to_install} already exists."
  else
    if brew install "$package_to_install"; then
      success "Package ${package_to_install} installation succeeded."
    else
      error "Package ${package_to_install} installation failed."
      exit 1
    fi
  fi
}

function install_dotfiles_role() {
  info "Installing dotfiles Ansible role..."
  if [[ -d ./roles ]] && [[ -f ./roles/requirements.yml ]]; then
	  ansible-galaxy install -r roles/requirements.yml \
      -p roles --no-deps --force --keep-scm-meta
    success "Installing dotfiles Ansible role succeeded"
  else
	  error "Installing dotfiles Ansible role failed."
	  exit 1
  fi
}

function colored_echo() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}

function info() {
  colored_echo "$1" blue "========>"
}

function substep() {
  colored_echo "$1" magenta "===="
}

function success() {
  colored_echo "$1" green "========>"
}

function error() {
  colored_echo "$1" red "========>"
}

case "$1" in
  install_command_line_tools)
    install_command_line_tools
    ;;
  install_homebrew)
    install_homebrew
    ;;
  brew_install)
    brew_install
    ;;
  install_dotfiles_role)
    install_dotfiles_role
    ;;
  *)
    main "$@"
esac
