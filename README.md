# 🎨 Hex Color Generator

**Hex Color Generator** is a sleek and minimalistic iOS application built with **SwiftUI** that allows users to effortlessly generate random colors along with their Hex and RGB values. The app is designed to support both **dark and light mode**, ensuring a seamless user experience across all display preferences.

## ✨ Features

- 🔁 **Random Hex Color Generator**  
  Instantly generate random colors and view their Hex and RGB representations.

- ⭐ **Favorite Your Colors**  
  Like a color? Add it to your **Favorites** with a tap and revisit it anytime.

- 💾 **Offline Access with Firebase Firestore Sync**  
  All favorite colors are stored in **Firestore** and synced with your device. Even without internet access, previously saved colors remain accessible.

- 🌓 **Dark & Light Mode Support**  
  The UI automatically adapts to your system's appearance settings.

## 🔧 Tech Stack

- **SwiftUI** – For building modern, reactive UIs.
- **Firebase Firestore** – To store and retrieve favorite colors.
- **Combine** – For reactive state management.
- **UserDefaults** – For handling small local data caching when offline.

## 📲 How It Works

1. Open the app to generate a random hex color.
2. View the color’s **Hex** and **RGB** values instantly.
3. Like a color? Tap the ⭐ to **add it to favorites**.
4. Your favorite colors are automatically synced to Firestore.
5. You can access your favorites **offline**, even without internet connectivity.
6. The app supports **both dark and light appearance modes**, ensuring comfortable viewing at all times.

## 🚀 Getting Started

1. Clone this repository.
   ```bash
   git clone https://github.com/jettspanner123/hexer
2. Open the project in Xcode.
3. Set up your Firebase project and replace the `GoogleService-Info.plist`.
4. Run the app on a simulator or real device.

## 📂 Folder Structure

```plaintext
├── Fonts
├── Models/
├── Views/
    ├── Components
    ├── Pages

