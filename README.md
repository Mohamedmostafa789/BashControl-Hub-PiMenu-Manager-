# **PiMenu Manager**  
*A Modular, Menu-Driven System Management Tool for Linux/Raspberry Pi*  

## **Project Overview**  
**PiMenu Manager** is a **Bash-based interactive system utility** designed to streamline common administrative tasks on Linux systems (including Raspberry Pi) through a user-friendly, text-based menu interface. Built with modularity and configurability in mind, it leverages `rofi` for dynamic menu rendering and integrates with core Linux tools (`nmcli`, `pactl`, `rsync`, etc.) to provide:  
- **System control** (power, WiFi, backups)  
- **File/network utilities**  
- **Mathematical tools**  
- **Customizable themes/languages**  

---

## **Key Features**  

### **1. Core Functionalities**  
| Feature               | Description                                                                 | Tools Used          |  
|-----------------------|-----------------------------------------------------------------------------|---------------------|  
| **File Navigator**    | Search/open files, manage bookmarks, track recent files.                    | `find`, `xdg-open`  |  
| **WiFi Management**   | Connect/disconnect to networks, list available SSIDs.                       | `nmcli`             |  
| **System Power**      | Shutdown, reboot, or suspend the system.                                    | `systemctl`         |  
| **Volume Control**    | Adjust audio levels/mute via PulseAudio.                                    | `pactl`             |  
| **Backups**           | Create/restore backups with optional cron scheduling.                       | `rsync`, `cron`     |  

### **2. Advanced Tools**  
- **Mathematical Equations**: Solve quadratic formulas, compound interest, etc. (`bc`).  
- **Weather API**: Fetch real-time weather data (OpenWeatherMap integration).  
- **Multi-Language Support**: Switch UI language (English/Spanish/French).  
- **Error Logging**: Debugging mode and log file (`~/.system_manager.log`).  

### **3. User Customization**  
- **Config File**: Persistent settings in `~/.system_manager.conf` (default directory, theme, etc.).  
- **Themes**: Light/dark mode support.  

---

## **Technical Implementation**  

### **Code Structure**  
```bash
.
├── load_config()           # Loads/Creates config file  
├── main_menu()             # Main interactive menu (rofi)  
├── handle_choice()         # Routes user input to functions  
│   ├── navigator()         # File navigation  
│   ├── wifi_management()   # WiFi controls  
│   └── [...]               # 20+ other modular functions  
└── utilities/              # Math/API helpers (e.g., quadratic_formula())  
```

### **Dependencies**  
- **Required**: `rofi`, `nmcli`, `pactl`, `bc`, `curl`, `rsync`, `jq`.  
- **Raspberry Pi**: Compatible with Pi 3/4/5 (Debian-based OS).  

---

## **Why Use PiMenu Manager?**  
✅ **Raspberry Pi-Optimized**: Lightweight and CLI-focused for low-resource environments.  
✅ **Extensible**: Easily add new modules (e.g., hardware monitoring).  
✅ **User-Friendly**: No memorizing commands—menus guide workflows.  

---

## **Setup & Usage**  
1. **Install Dependencies**:  
   ```bash
   sudo apt install rofi nmcli pactl bc curl rsync jq
   ```  
2. **Run the Script**:  
   ```bash
   chmod +x system_manager.sh && ./system_manager.sh
   ```  

---

## **Roadmap**  
- [ ] Add GPIO control (Raspberry Pi hardware).  
- [ ] Expand weather API with location detection.  
- [ ] Plugin system for community contributions.  

