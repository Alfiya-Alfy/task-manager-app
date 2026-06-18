# Task Manager Flutter App

## Overview

Task Manager is a Flutter application developed as part of a machine test. The application fetches tasks from a public API, allows users to search and filter tasks, view task details, add new tasks locally, and persist locally added tasks using SharedPreferences.

## Features

### API Integration

* Fetch tasks from:
  https://jsonplaceholder.typicode.com/todos
* Loading indicator while fetching data
* Error handling with Retry option

### Task List

* Display task title
* Display completion status
* Checkbox indicator
* Pull-to-refresh support

### Search Functionality

* Search tasks by title
* Real-time filtering
* Displays "No tasks found" when no results match

### Filter Options

* All Tasks
* Completed Tasks
* Pending Tasks

### Task Details

* Task ID
* User ID
* Task Title
* Completion Status

### Add New Task

* Task Title (Required)
* Completion Status Switch
* Form Validation
* Local task creation

### Local Persistence

* Uses SharedPreferences
* Stores locally added tasks
* Tasks remain available after app restart

---

## Project Structure

lib/

├── models/

│ └── task_model.dart

├── services/

│ ├── api_service.dart

│ └── local_storage_service.dart

├── screens/

│ ├── task_list_screen.dart

│ ├── task_detail_screen.dart

│ └── add_task_screen.dart

├── main.dart

---

## Packages Used

### http

Used for API communication.

### shared_preferences

Used for local data persistence.

---

## Flutter Version

Flutter 3.x

Dart 3.x

---

## Installation

### Clone Repository

git clone <repository-url>

cd task_manager

### Install Dependencies

flutter pub get

### Run Application

flutter run

### Run on Chrome

flutter run -d chrome

### Build APK

flutter build apk --release

Generated APK location:

build/app/outputs/flutter-apk/app-release.apk

---

## API Used

JSONPlaceholder Todos API

https://jsonplaceholder.typicode.com/todos

---

## Screens

### Task List Screen

* Search tasks
* Filter tasks
* View all fetched tasks
* Add new task

### Task Detail Screen

* View task information

### Add Task Screen

* Create local task
* Validate input

---

## Evaluation Criteria Covered

✔ API Integration

✔ UI Implementation

✔ Search Functionality

✔ Filter Functionality

✔ Form Validation

✔ Local Storage

✔ Code Organization

✔ Pull To Refresh (Bonus)

Due to Gradle/Kotlin environment issue, release APK build failed, but project runs successfully in debug mode.
---

## Author

Alfiya Nazer

Flutter Machine Test Submission

