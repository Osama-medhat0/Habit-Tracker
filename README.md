# 📊 Habit Tracker Application – Data Item Design

This document outlines the **data structure and storage strategy** for a Flutter-based Habit Tracker App. The app is designed to help users manage daily habits, track completion, and visualize progress through heatmaps.

---

## 🧑‍💼 1. User Data

- **Purpose:** Store user authentication and basic profile info  
- **Storage:**
  - 📡 Firebase Authentication (cloud)
  - 📦 Hive (local caching)
  
- **Fields:**
  | Field      | Type      | Description                         |
  |------------|-----------|-------------------------------------|
  | `uid`      | String    | Unique Firebase user ID             |
  | `email`    | String    | User’s email address                |
  | `username` | String    | Username (derived from email)       |
  | `createdAt`| DateTime  | Account creation timestamp          |

---

## ✅ 2. Habit Data

- **Purpose:** Track user's habits and their daily status  
- **Storage:** Hive (per-user local database)  
- **Format:**  
  - `List<Habit>` — a model containing habit name, ID, status, and creation info

---

## 📅 3. Daily Habit Records

- **Purpose:** Store a user’s habit completions on a daily basis  
- **Storage:** Hive box  
- **Structure:**
  - **Key:** `YYYYMMDD` (e.g., `"20230711"`)
  - **Value:** `List<Habit>` (habits recorded for that day)

---

## 🧾 4. Current Habit List

- **Purpose:** Master list of all habits the user is tracking  
- **Storage:** Hive  
- **Structure:**
  - **Key:** `"Current_Habit_List"`
  - **Value:** `List<Habit>` (active user habits)

---

## 📈 5. Habit Progress Data

- **Purpose:** Track daily habit completion percentage (for heatmap)
- **Storage:** Hive  
- **Structure:**
  - **Key:** `"Habit_Percentage_YYYYMMDD"`
  - **Value:** `double` (percentage from `0.0` to `1.0`)

---

## ✨ Core Features

### 1. 🔐 User Registration & Authentication
- Email sign-up, login, and password reset
- Backed by Firebase Authentication

### 2. ➕ Add & Manage Habits
- Create, edit, and delete habits (e.g., "Drink Water", "Exercise")

### 3. ✅ Daily Habit Tracking
- Mark habits as complete for the current day
- Automatically recorded in Hive with date-stamped keys

### 4. 📊 Progress Visualization
- View completion stats through a **calendar heatmap**
- Color intensity indicates consistency and progress

---

## 🧠 Technologies Used

- **Flutter** – App development
- **Firebase Authentication** – User login system
- **Hive** – Lightweight local NoSQL database
- **Provider / Riverpod** – (Assumed) State management

---

## 📁 File & Box Naming Recommendations

| Type                    | Box Name / Key Example               |
|-------------------------|--------------------------------------|
| Daily habits            | `habit_box_20230711`                 |
| All active habits       | `"Current_Habit_List"`               |
| Completion % per day    | `"Habit_Percentage_20230711"`        |

---

## 📌 Notes

- Avoid mixing active and completed habits in the same box
- Ensure all date keys use the `YYYYMMDD` format for consistency
- Consider syncing Hive data with cloud backup in the future

---

## 📸 Screenshots

<img width="392" height="851" alt="Login" src="https://github.com/user-attachments/assets/357e11c8-3bc3-4556-b53e-ef4105cb1e4d" />
<img width="392" height="851" alt="Register" src="https://github.com/user-attachments/assets/d9e4991e-23b8-49d0-b97e-3eb41d89b552" />
<img width="392" height="851" alt="Dashboard" src="https://github.com/user-attachments/assets/deb81541-1889-437d-a901-35453f163f94" />
<img width="392" height="851" alt="Heatmap progress" src="https://github.com/user-attachments/assets/f38368f6-d4c6-4c87-b55d-5776b6edd9bd" />
<img width="392" height="851" alt="Edit" src="https://github.com/user-attachments/assets/48b59b6c-6788-49f1-b58e-928e6c81e416" />

---

> Designed for scalability and offline-first experience.
