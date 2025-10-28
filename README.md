# sysden64

![License](https://img.shields.io/github/license/automation64/sysden64)
![GitHub stars](https://img.shields.io/github/stars/automation64/sysden64?style=social)
![GitHub forks](https://img.shields.io/github/forks/automation64/sysden64?style=social)

🚀 **SysDen64** is an opinionated, portable working environment designed for the command line warrior who need a flexible and efficient setup on the go.

---

## 📌 Overview

**SysDen64** provides a centralized and modular configuration repository for command line tools that enables users to maintain consistency across different machines and environments.

Main features

- Out-of-the-box configuration defaults for popular command line tools
- GIT friendly configuration repository for tracking configuration changes
- Multiple environment support using configuration profiles
- Modular design to facilitate adding new tools

---

## 📦 Installation

**SysDen64** can be installed using the **Installer64** tool:

```shell
curl -sL https://raw.githubusercontent.com/automation64/installer64/main/src/bootstrap | sh
sudo /opt/inst64/install-devbin64 && sudo /opt/inst64/install-sysden64
```

---

## 🚀 Usage

- Create configuration repository

```sh
sysden64 -s
```

- (Optional) customize defaults by editing configuration files:
  - `$HOME/sd64/etc/shared/<MODULE>/`: module specific configuration files
  - `$HOME/sd64/etc/shared/custom/.env.d`: shell startup variables, aliases, paths, functions

- Apply configuration changes. Warning: tools that do not support live update may need to be restarted.

```sh
# Update one modules
sysden64 -u -m <MODULE>
# Or update all modules
sysden64 -u
```

- (Optional) Protect module. Use this option to prevent **SysDen64** upgrades from replacing your module customizations.

```sh
sysden64 -d -m <MODULE>
```

- (Optional) Upgrade **SysDen64** module defaults. Warning: this option will replace current module definitions with defaults, except for protected modules.

```sh
sysden64 -g
```

---

## 🛠 Contributing

Contributions are welcome! Help us improve by submitting issues, feature requests, or pull requests.

- [Code of Conduct](https://github.com/automation64/sysden64/blob/main/CODE_OF_CONDUCT.md)

---

## 📜 License

SysDen64 is licensed under the [Apache-2.0 License](https://www.apache.org/licenses/LICENSE-2.0.txt).

---

## 👤 Author

- [SerDigital64](https://github.com/serdigital64)

---

🌟 **If you find this project useful, consider giving it a star!** ⭐
