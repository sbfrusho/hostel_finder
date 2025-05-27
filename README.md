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

lib/
├── core/ # Shared logic (constants, helpers, services)
├── features/ # Feature-specific folders (hostel, auth, etc.)
│ ├── data/ # Data sources, models, repository implementations
│ ├── domain/ # Entities, use cases, abstract repositories
│ └── presentation/ # UI widgets, screens, providers
├── shared/ # Reusable components like themes, widgets, routing
├── injection.dart # Service locator (DI)
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

