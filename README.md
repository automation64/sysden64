# sysden64

![License](https://img.shields.io/github/license/automation64/sysden64)
![GitHub stars](https://img.shields.io/github/stars/automation64/sysden64?style=social)
![GitHub forks](https://img.shields.io/github/forks/automation64/sysden64?style=social)

🚀 **SysDen64** is an opinionated, portable working environment designed for the command line warrior who need a flexible and efficient setup on the go.

---

## 📌 Overview

SysDen64 provides a modular, customizable environment that enables IT professionals to maintain consistency and efficiency across different machines and environments. It simplifies configuration management, profile switching, and module synchronization.

---

## 📦 Installation

Install SysDen64 in your home directory (no root privilege required): $HOME/at64/sysden64

```sh
INST64_RELEASE="$(curl -s "https://api.github.com/repos/automation64/installer64/releases/latest" | grep '"tag_name":' | cut -d '"' -f 4)" &&
test -n "$INST64_RELEASE" && curl -LO https://github.com/automation64/installer64/releases/download/${INST64_RELEASE}/install-installer64 &&
chmod 755 ./install-installer64 &&
./install-installer64 &&
./at64/inst64/install-sysden64
```

---

## 🚀 Usage

Run `sysden64` with the appropriate flags:

```sh
sysden64 <-s|-l|-w|-u|-g> [-o Home] [-i Repo] [-p Profile] [-V Verbose] [-D Debug] [-h]
```

### Available Commands:

| Command      | Description                                                                       |
| ------------ | --------------------------------------------------------------------------------- |
| `-s`         | Create a user-wide configuration                                                  |
| `-l`         | Create a system-wide configuration                                                |
| `-u`         | Synchronize the current configuration                                             |
| `-w`         | Switch to the specified configuration profile (requires `-p`)                     |
| `-g`         | Upgrade user-wide modules                                                         |
| `-h`         | Show help                                                                         |
| `-o Home`    | Set the full path to the user's home directory (defaults to `$HOME`)              |
| `-i Repo`    | Set the path to the configuration repository (defaults to `$HOME/sd64`)           |
| `-p Profile` | Specify the configuration profile name (required for `-w`, defaults to `default`) |
| `-V Verbose` | Set verbosity level (Format: `BL64_MSG_VERBOSE_*`)                                |
| `-D Debug`   | Enable debugging mode (Format: `BL64_DBG_TARGET_*`)                               |

Example:

```sh
# Create a local configuration repository and deploy default configuration files
sysden64 -s
```

---

## 🛠 Contributing

Contributions are welcome! Help us improve by submitting issues, feature requests, or pull requests.

- [Contribution Guidelines](https://github.com/automation64/sysden64/blob/main/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/automation64/sysden64/blob/main/CODE_OF_CONDUCT.md)

---

## 📜 License

SysDen64 is licensed under the [Apache-2.0 License](https://www.apache.org/licenses/LICENSE-2.0.txt).

---

## 👤 Author

- [SerDigital64](https://github.com/serdigital64)

---

🌟 **If you find this project useful, consider giving it a star!** ⭐
