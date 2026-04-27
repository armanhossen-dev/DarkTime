# App Initialization Terminal Commands

Follow these steps in your terminal (macOS/Linux) or PowerShell (Windows) to build your project structure.

## 1. Create Project Folder & Files
```bash
# Create the project directory
mkdir clock-app && cd clock-app

# Create the core files
touch index.html style.css script.js

# Initialize a git repository (Optional)
git init


# Open in VS Code to paste your code
code .


Convert to a Mobile App (Capacitor)
# turn this HTML/CSS/JS into a native Android/iOS app

# Initialize npm
npm init -y

# Install Capacitor Core
npm install @capacitor/core @capacitor/cli

# Initialize Capacitor
npx cap init "DarkTime" "com.darktime.app" --web-dir .

# Add Platforms
npm install @capacitor/android @capacitor/ios
npx cap add android
npx cap add ios

# Open Android Studio or Xcode to build the final app
npx cap open android
npx cap open ios


-----------------------------------------
Convert to a Desktop App (Electron)
# Install Electron
npm install electron --save-dev

# Create the main entry file for Electron
touch main.js

-------------------------------------------
Local Development Server
# If you have Python installed
python3 -m http.server 8080

# Or if you have Node/NPM installed
npx serve .


---

### Which path are you planning to take?
* **Web Only:** Just use Step 1 & 5.
* **Mobile:** Follow Step 1, then Step 3.
* **Desktop:** Follow Step 1, then Step 4.