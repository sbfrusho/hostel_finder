# 🏠 Hostel Finder App

A modern mobile application built using **Flutter** that helps users find hostels easily and allows hostel owners to post and manage their listings. The app features **bKash/Nagad/Rocket payment integration**, shared preferences for local storage, and implements **Clean Architecture** with **Provider** for state management.

---

## 📦 Features

- User and Owner login/registration
- Search hostels with filters and map view
- View hostel details with images and location
- Save/bookmark hostels
- Owners can add/update hostel listings with camera integration
- Owners are notified to update room images if not rented in 6 months
- Payments via bKash/Nagad/Rocket
- Local storage with SharedPreferences
- Network handling and error screens

---

## 🧱 Architecture

This project follows **Clean Architecture** with the following layers:

# Project Structure
lib/
├── core/ # Shared app logic (constants, utils, services)
│ ├── constants/ # App-wide strings, enums, numbers
│ ├── utils/ # Helpers (validators, date formatters)
│ └── services/ # Network, local storage, DI
│
├── features/ # Feature modules (Clean Architecture layers)
│ ├── auth/ # Authentication
│ │ ├── data/ # Data sources (Firebase, local DB)
│ │ │ ├── datasources/
│ │ │ ├── models/
│ │ │ └── repositories/
│ │ ├── domain/ # Business logic
│ │ │ ├── entities/
│ │ │ ├── repositories/
│ │ │ └── usecases/
│ │ └── presentation/ # UI
│ │ ├── screens/
│ │ ├── widgets/
│ │ └── providers/
│ │
│ ├── hostel/ # Hostel management
│ │ ├── data/ # (Same structure as auth)
│ │ ├── domain/
│ │ └── presentation/
│ │
│ └── payment/ # Payments (bKash/Nagad)
│ ├── data/
│ ├── domain/
│ └── presentation/
│
├── shared/ # Reusable components
│ ├── themes/ # AppTheme, colors, text styles
│ ├── widgets/ # Buttons, dialogs, loaders
│ ├── router/ # AppRoutes, route guards
│ └── utils/ # Global helpers (snackbars, etc.)
│
├── injection.dart # Dependency injection (GetIt + Injectable)
└── main.dart # App entry point


---

## 🛠 Technologies Used

- **Flutter**
- **Dart**
- **Clean Architecture**
- **Provider** (state management)
- **SharedPreferences** (local database)
- **Dio** (API client)
- **Injectable & GetIt** (dependency injection)
- **BDApps API** (optional integration)
- **Firebase (optional)** for notifications/auth
- **bKash/Nagad/Rocket** (custom payment integration)

---

## 📱 Screens

### 👤 General User Screens

- Splash Screen  
- Onboarding Screen *(optional)*  
- Login Screen  
- Register Screen  
- Home Screen  
- Hostel List Screen  
- Hostel Details Screen  
- Save/Bookmark Hostel Screen  
- Book Appointment / Contact Owner Screen  
- Payment Screen *(bKash/Nagad/Rocket)*  
- Notifications Screen  
- User Profile Screen  
- Edit Profile Screen  
- Settings Screen  
- Change Password Screen  
- About / Terms & Conditions / Privacy Policy Screen  
- No Internet / Error Screen  

---

### 🧑‍💼 Owner Screens

- Owner Dashboard Screen  
- Add Hostel Screen *(with app camera access)*  
- Update Hostel Info Screen  
- Upload New Room Image Screen *(mandatory after 6 months)*  
- Owner Hostel List Screen  
- Booking Requests Screen  
- Earnings Screen  

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/hostel_finder_app.git
cd hostel_finder_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run

