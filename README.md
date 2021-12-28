# dotfiles_playbook

1. [dotfiles_playbook](#dotfiles_playbook)
2. [Getting started](#getting-started)
    1. [Deploy the entire configuration or parts of it](#deploy-the-entire-configuration-or-parts-of-it)
    2. [Install prerequisites](#install-prerequisites)
        1. [Install all prerequisites](#install-all-prerequisites)
        2. [Install Apple's command line tools](#install-apples-command-line-tools)
        3. [Install Homebrew](#install-homebrew)
        4. [Install Ansible](#install-ansible)
        5. [Install dotfiles Ansible role](#install-dotfiles-ansible-role)

The [dotfiles_playbook](https://github.com/Harppi/dotfiles_playbook) Ansible
playbook deploys the [dotfiles](https://github.com/Harppi/dotfiles) Ansible
role.

## Getting started

Clone the [dotfiles_playbook](https://github.com/Harppi/dotfiles_playbook) and
follow any of the instructions below.

### Deploy the entire configuration or parts of it

Follow the instructions in the `README` file of the
[dotfiles](https://github.com/Harppi/dotfiles/blob/master/README.md) Ansible
role.

### Install prerequisites

Install the prerequisites or parts of them by running any of the following.

#### Install all prerequisites

This command installs all prerequisites that enable running Ansible playbooks.

```shell
./prepare.sh
```

#### Install Apple's command line tools

This command installs Apple's command line tools for Xcode.

```shell
./prepare.sh install_command_line_tools
```

#### Install Homebrew

This command installs the Homebrew package manager.

```shell
./prepare.sh install_homebrew
```

#### Install Ansible

This command installs the Ansible community package.

```shell
./prepare.sh brew_install
```

#### Install dotfiles Ansible role

This command installs the dotfiles Ansible role to the `roles` directory by
using Ansible Galaxy.

```shell
./prepare.sh install_dotfiles_role
```
