![dotfiles-logo](./assets/dotfiles.png)
# dotfiles_automate
Fully automated development environment for GertGerber

This repo is heavily influenced by [Techdufus](https://github.com/TechDufus/dotfiles)'s repo. Go check it out!

## 📋 Table of Contents

- [📋 Prerequisites](#-prerequisites)
- [🚀 Quick Start](#-quick-start)
- [🎯 Goals](#goals)
- [⚙️ Requirements](#requirements)
- [🔧 Setup](#setup)
- [📖 Usage](#usage)
- [📚 Documentation](#documentation)
- [⭐ Star History](#-star-history)

## 📋 Prerequisites
### Ubuntu & WSL Operating Systems
No prerequisites needed - the bootstrap script handles everything automatically.

## 🚀 Quick Start

**New to dotfiles?** → [Complete Beginner Guide](docs/QUICKSTART.md)

**Want it fast?** Run this one command (5-10 minutes):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GertGerber/dotfiles_automate/main/bin/dotfiles)"
```

**What happens:**
1. **Prerequisites** - Installs Ansible and dependencies for your OS
2. **Bootstrap** - Downloads and runs the dotfiles automation
3. **Configure** - Edit `~/.dotfiles/group_vars/all.yml` for your preferences

**Next steps:**
- Customize your setup by editing `~/.dotfiles/group_vars/all.yml`
- Run `dotfiles` anytime to update your environment

---
## 🎯 Goals

Provide fully automated multiple-OS development environment that is easy to set up and maintain.

### Why Ansible?

Ansible replicates what we would do to set up a development environment pretty well. There are many automation solutions out there - I happen to enjoy using Ansible.

## ⚙️ Requirements

### Operating System

This Ansible playbook only supports multiple OS's on a per-role basis. This gives a high level of flexibility to each role.

This means that you can run a role, and it will only run if your current OS is configured for that role.

This is accomplished with this `template` `main.yml` task in each role:
```yaml
---
- name: "{{ role_name }} | Checking for Distribution Config: {{ ansible_distribution }}"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/{{ ansible_distribution }}.yml"
  register: distribution_config

- name: "{{ role_name }} | Run Tasks: {{ ansible_distribution }}"
  ansible.builtin.include_tasks: "{{ ansible_distribution }}.yml"
  when: distribution_config.stat.exists
```

The first task checks for the existence of a `roles/<target role>/tasks/<current_distro>.yml` file. If that file exists (example `current_distro:Ubuntu` and a Ubuntu.yml` file exists) it will be run automatically. This keeps roles from breaking if you run a role that isn't yet supported or configured for the system you are running `dotfiles` on.

Currently configured 'bootstrap-able' OS's:
- Ubuntu
- WSL

`bootstrap-able` means the pre-dotfiles setup is configured and performed automatically by this project. For example, before we can run this ansible project, we must first install ansible on each OS type.

To see details, see the `__task "Loading Setup for detected OS: $ID"` section of the `bin/dotfiles` script to see how each OS type is being handled.

### System Upgrade

Verify your `supported OS` installation has all latest packages installed before running the playbook.

```
# Ubuntu
sudo apt-get update && sudo apt-get upgrade -y
#WSL
sudo apt-get update && sudo apt-get upgrade -y
```

> [!NOTE]
> This may take some time...

## 🔧 Setup

### all.yml values file

The `all.yml` file allows you to personalize your setup to your needs. This file will be created in the file located at `~/.dotfiles/group_vars/all.yml` after you [Install this dotfiles](#install) and include your desired settings.

Below is a list of all available values. Not all are required but incorrect values will break the playbook if not properly set.

| Name             | Type                                   | Required |
| ---------------- | -------------------------------------- | -------- |
| git_user_name    | string                                 | yes      |
| op               | object `(see OP Variable below)`       | yes      |
| go.packages      | list `(for extra go bin installs)`     | no       |
| helm.repos       | list `(add extra helm repos)`          | no       |
| k8s.repo.version | string `(specify kubectl bin version)` | no       |

## 📖 Usage

### Install

This playbook includes a custom shell script located at `bin/dotfiles`. This script is added to your $PATH after installation and can be run multiple times while making sure any Ansible dependencies are installed and updated.

This shell script is also used to initialize your environment after bootstrapping your `supported-OS` and performing a full system upgrade as mentioned above.

> [!NOTE]
> You must follow required steps before running this command or things may become unusable until fixed.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GertGerber/dotfiles_automate/main/bin/dotfiles)"
```

If you want to run only a specific role, you can specify the following bash command:
```bash
curl -fsSL https://raw.githubusercontent.com/GertGerber/dotfiles_automate/main/bin/dotfiles | bash -s -- --tags comma,seperated,tags
```

### Update

This repository is continuously updated with new features and settings which become available to you when updating.

To update your environment run the `dotfiles` command in your shell:

```bash
dotfiles
```

This will handle the following tasks:

- Verify Ansible is up-to-date
- Clone this repository locally to `~/.dotfiles`
- Verify any `ansible-galaxy` plugins are updated
- Run this playbook with the values in `~/.dotfiles/group_vars/all.yml`

This `dotfiles` command is available to you after the first use of this repo, as it adds this repo's `bin` directory to your path, allowing you to call `dotfiles` from anywhere.

Any flags or arguments you pass to the `dotfiles` command are passed as-is to the `ansible-playbook` command.

For Example: Running the tmux tag with verbosity
```bash
dotfiles -t tmux -vvv
```

As an added bonus, the tags have tab completion!
```bash
dotfiles -t <tab><tab>
dotfiles -t t<tab>
dotfiles -t ne<tab>
```

## 📚 Documentation

- [📖 Complete Beginner Guide](docs/QUICKSTART.md) - Step-by-step setup for new users
- [🔧 Troubleshooting Guide](docs/TROUBLESHOOTING.md) - Common issues and solutions
- [📋 Configuration Examples](docs/EXAMPLES.md) - Sample setups for different use cases

