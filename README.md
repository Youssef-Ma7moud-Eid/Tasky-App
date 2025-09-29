# ✅ Tasky App

A **Flutter productivity application** that helps users organize daily tasks with reminders, progress tracking, and task prioritization.  

Tasky leverages **Firebase Authentication**, **Isar Database**, **Cubit State Management**, and **Local Notifications** to deliver a complete and modern task management experience.

---

## 🚀 Features

### 🔐 Authentication
- Firebase Authentication (Login / Sign Up).
- Regular Expression validation for email & password.
- Success confirmation dialog on login.

### 🖼️ UI/UX
- Native-like animated splash screen.  
- Smooth animated onboarding screens.  
- Responsive design for all devices.  
- BottomSheet for adding new tasks.  
- Dialogs for priority & date selection.  

### 📋 Task Management
- Add, Update, Delete tasks with **Isar Database**.  
- Task details include: **Title, Description, Date, Time, Priority**.  
- Dropdown filter: **Today | Tomorrow | All**.  
- Search tasks with **Streams** for real-time results.  
- **Cubit State Management**:
  - Handles task list filtering.  
  - Updates UI dynamically (shows empty state if no tasks available for selected day).  

### 🔔 Notifications
- Local notifications with scheduling.  
- Works in **background, foreground, and killed app states**.  
- Task reminders fire at exact scheduled date & time.  

### 📊 Analytics
- Progress tracking with charts:
  - **Pie Chart** → task completion ratio.  
  - **Bar Chart** → weekly progress analysis.  

### ⚡ State Management
- Cubit (BLoC) for predictable and scalable state management.  
- ValueNotifier to update BottomSheet selections (date & priority).  

---

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)  
- **Architecture**: Clean Architecture + Feature-based  
- **State Management**: Cubit (BLoC)  
- **Database**: Isar (local database, CRUD operations)  
- **Authentication**: Firebase Auth  
- **Notifications**: Flutter Local Notifications  
- **Charts**: fl_chart package  

---

## 🏗️ Project Structure

```bash
lib/
├── core/                          # Core shared logic
│   ├── bloc_observer/             # Cubit/BLoC observer
│   ├── functions/                 # Helper functions (validators, navigation, etc.)
│   ├── services/                  # Notification, Firebase services
│   ├── utils/                     # Constants, enums, app helpers
│   └── widgets/                   # Reusable widgets
│
├── features/                      # Feature-based modules
│   ├── add-task/                  
│   │   ├── data/                  
│   │   │   └── local-database/    # Isar CRUD operations
│   │   ├── model/                 # Task model(s)
│   │   └── presentation/          # Cubit + UI (Add Task screen, BottomSheet)
│   │
│   ├── edit-task/                 
│   │   ├── views/                 # Screens
│   │   └── widgets/               # Reusable components
│   │
│   ├── auth/                      
│   │   ├── data/                  # Firebase Auth methods
│   │   ├── model/                 # User model
│   │   └── presentation/          # Cubit + UI (login, signup screens)
│   │
│   ├── onboarding/                
│   │   ├── views/                 # Screens
│   │   └── widgets/               # Onboarding widgets
│   │
│   └── home/                      
│       ├── views/                 # Home screen, filters, search
│       └── widgets/               # Task cards, filter dropdown, empty state
│
├── firebase_options.dart           # Firebase config
└── main.dart                       # App entry point

## 📱 Screenshots


