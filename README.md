# dotfiles-linux

This repository contains my **Linux dotfiles and configuration files**, focused on a
**minimalist suckless-based environment** running on **Debian GNU/Linux** with **dwm**
as the window manager.

The goal of this repository is to keep my setup **versioned, organized, and reproducible**.
Although it is intended for personal use, it may serve as a reference for others.

---

## 🖥️ System

- **Operating System:** Debian GNU/Linux 13 (trixie)
- **Kernel:** Linux 6.12.x
- **Shell:** bash 5.2
- **Display Server:** X11
- **Window Manager:** dwm (suckless)

---

## 🎨 Appearance

- **GTK Theme:** Orchis-Grey-Dark
- **Icon Theme:** Colloid-Grey-Dracula-Dark
- **Cursor Theme:** Adwaita
- **System Font:** Sans (10pt)
- **Terminal Emulator:** WezTerm
- **Terminal Font:** Lilex Nerd Font Mono

---

## 🧱 Core Components

- **dwm** – Window Manager  
- **st** – Suckless terminal  
- **slstatus** – Status bar  
- **rofi** – Application launcher  
- **picom** – Compositor  
- **dunst** – Notification daemon  
- **sxhkd** – Hotkey daemon  
- **tabbed** – Suckless tabbed container  

---

## 📁 Repository Structure

```text
.
├── dwm/        # Window manager configuration
├── st/         # Suckless terminal
├── slstatus/   # Status bar
├── dunst/      # Notifications
├── rofi/       # Application launcher
├── picom/      # Compositor
├── sxhkd/      # Hotkeys
├── tabbed/     # Suckless tabbed
├── scripts/    # Custom scripts
└── wallpaper/  # Wallpapers
```
Each directory contains the corresponding configuration files or source code.

---

## 🧰 UI & System Tools

Graphical tools and system utilities used in this environment:

| Componente               | Propósito                                  |
|--------------------------|--------------------------------------------|
| rofi                     | App launcher + visor de keybinds           |
| dunst                    | Lightweight notifications                  |
| feh                      | Wallpaper setter                           |
| lxappearance             | GGTK theme manager                         |
| network-manager          | NetworkManager applet                      |
| nemo                     | File manager                               |
| pavucontrol              | Audio control (GUI)                        |
| xfce4-power-manager      | Power management                           |
| flameshot                | Screenshot tool                            |
| qimgv                    | image viewer                               |
| firefox-esr              | Default web browser                        |

---

## 🧩 Additional Applications

Besides the core components, the following applications are also used:

- **Nemo**  
  File Manager.
  
- **Solaar**  
  Logitech mouse and keyboard management.

- **NVIDIA Drivers**  
  Installed using the following project:
https://github.com/devleonardoamaral/debian-nvidia-installer

- **btop++**  
  Resource and process monitor.

- **CopyQ**  
  Clipboard manager with history.

- **DBeaver**  
  SQL database management tool.

- **Gedit**  
  Extra text editor.

- **DroidCam Client**  
  Use a smartphone as a webcam.
  
---

## ⌨️ Keybindings (sxhkd)

All keybindings are managed using **sxhkd**.  
The **Super** key refers to the **Windows** key.

---

### 🌐 Applications

| Shortcut | Action |
|--------|--------|
| `Super + B` | Launch Firefox ESR |
| `Super + Shift + B` | Launch Firefox (private mode) |
| `Super + Space` | Launch application menu (rofi) |
| `Super + F` | Launch file manager (Nemo) |
| `Super + E` | Launch text editor (Geany) |
| `Super + G` | Launch GIMP |
| `Super + D` | Launch Discord |
| `Super + O` | Launch OBS |
| `Super + C` | Launch Helium Browser |
| `Super + Shift + C` | Launch Helium Browser (incognito) |

---

### 🪟 DWM / Suckless

| Shortcut | Action |
|--------|--------|
| `Super + Shift + L` | Open dwm layout menu |
| `Super + T` | Attach focused window to tab group |
| `Super + Alt + T` | Detach focused window from tab group |

### 🧭 Utilities

| Shortcut | Action |
|--------|--------|
| `Super + /` | Show keybinding help |
| `Super + Escape` | Reload sxhkd configuration |

### 🔊 Audio

| Shortcut | Action |
|--------|--------|
| `Super + Insert` | Increase volume |
| `Super + Delete` | Decrease volume |
| `Super + M` | Toggle mute |
| `XF86AudioRaiseVolume` | Increase volume |
| `XF86AudioLowerVolume` | Decrease volume |
| `XF86AudioMute` | Toggle mute |

### 🌞 Brightness

| Shortcut | Action |
|--------|--------|
| `XF86MonBrightnessUp` | Increase brightness |
| `XF86MonBrightnessDown` | Decrease brightness |

### 📸 Screenshots

| Shortcut | Action |
|--------|--------|
| `Print` | Fullscreen screenshot |
| `Super + Print` | Select region screenshot |
| `Super + Shift + S` | Select region screenshot |
| `Super + S` | Fullscreen screenshot |

Screenshots are saved to `~/Screenshots/`.

### ⏻ Power

| Shortcut | Action |
|--------|--------|
| `Super + X` | Power menu (shutdown / reboot) |
---

## 🛠️ Editing dwm Configuration (Notes)

This is my personal workflow for editing and applying changes to `dwm` configuration.
Saved here for quick reference.

### 🔁 Rebuild & Apply Changes

1. Edit `config.def.h`
2. Delete the generated `config.h`
3. Navigate to the dwm directory:
   ```bash
   cd ~/.config/suckless/dwm
4. sudo make clean install
5. Super + Shift + R

### 🖥️ Monitor Index Reference

| Value | Meaning |
|------:|---------|
| `monitor 0` | Monitor 1 (primary) |
| `monitor 1` | Monitor 2 |
| `monitor -1` | Any monitor |

---

### 🏷️ Tag Bitmask Reference

| Visible Tag | Internal Value |
|------------|----------------|
| Tag 1 | `1 << 0` |
| Tag 2 | `1 << 1` |
| Tag 3 | `1 << 2` |
| Tag 4 | `1 << 3` |
| Tag 5 | `1 << 4` |
| Tag 6 | `1 << 5` |
| Tag 7 | `1 << 6` |
| Tag 8 | `1 << 7` |
| Tag 9 | `1 << 8` |
| Tag 0 | Opens on the currently focused monitor |

---

## 💻 Setup on a New PC

1. git clone https://github.com/nando-dotjs/suckless.git ~/repos/suckless
2. chmod +x install-suckless-symlinks.sh
3. ./install-suckless-symlinks.sh

