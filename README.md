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
## 📱 Screenshots

<img width="377" height="312" alt="Image" src="https://github.com/user-attachments/assets/83f8f935-83cd-4333-b84d-6860a44ca341" /> <img width="370" height="312" alt="Image" src="https://github.com/user-attachments/assets/3791d83a-0259-4bab-8b0b-837aafdf0323" /> <img width="373" height="312" alt="Image" src="https://github.com/user-attachments/assets/3cfc3ca1-e29c-44f6-89cf-03cd9dc1a0d0" /> ![Image](https://github.com/user-attachments/assets/18760730-1713-402c-a336-e2ade2a7c367) <img width="372" height="312" alt="Image" src="https://github.com/user-attachments/assets/b47380ba-20a1-42da-886d-c56ac0cf1443" /> ![Image](https://github.com/user-attachments/assets/61a73e50-0937-4536-a7b5-cd5c296a155a) ![Image](https://github.com/user-attachments/assets/71528a88-0580-4b0a-a2cb-2c93d37ed9a3) ![Image](https://github.com/user-attachments/assets/230a8f45-913a-43a9-8841-cda8737691de) ![Image](https://github.com/user-attachments/assets/bc900597-ccea-4331-8052-dfe69e827f6e) ![Image](https://github.com/user-attachments/assets/b4f3b291-5d7b-402c-be82-922145ebf693) ![Image](https://github.com/user-attachments/assets/e77131a8-a00c-4b57-b352-6e04b5081eb0) ![Image](https://github.com/user-attachments/assets/b80983d4-170c-43fd-a1b7-d31e6d414ef2) ![Image](https://github.com/user-attachments/assets/8ebb349e-fa6c-4e84-98e3-f08fc6d68eeb) ![Image](https://github.com/user-attachments/assets/742ec284-dddf-4c08-bfc3-0f0c369659a8) ![Image](https://github.com/user-attachments/assets/f7a67b95-fc02-411c-8c50-b4b7db329160) ![Image](https://github.com/user-attachments/assets/d3cf5061-043b-4412-98f2-1c45d3ef5c03)

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




