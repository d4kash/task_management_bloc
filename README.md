# Task Manager Flutter App

## Overview

A Flutter application for managing tasks with features for adding, editing, filtering, sorting, and marking tasks as complete. This app uses BLoC for state management, SQLite for local data persistence, and provides an intuitive UI with responsive design and animations.

## Features

- **Add Tasks**: Create new tasks with title, description, and due date.
- **Edit Tasks**: Modify existing tasks and update their details.
- **Delete Tasks**: Remove tasks from the list.
- **Mark Complete**: Toggle tasks as completed or incomplete.
- **Filter Tasks**: Show tasks based on their completion status (all, completed, incomplete).
- **Sort Tasks**: Sort tasks by due date in ascending or descending order.
- **Responsive Design**: User-friendly UI that adapts to various screen sizes.
- **Animations**: Smooth transitions and animations for a better user experience.

## Screenshots

_Include screenshots of the app here_

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/d4kash/task_management_bloc.git
   cd task_management_bloc
   ```

2. **Install Dependencies**

   Make sure you have Flutter installed. Then, run:

   ```bash
   flutter pub get
   ```

3. **Run the Application**

   Ensure that an emulator is running or a device is connected, then execute:

   ```bash
   flutter run
   ```

## Usage

### Adding a Task

1. Navigate to the task list screen.
2. Tap the "+" button to add a new task.
3. Fill in the task details (title, description, due date) and save.

### Editing a Task

1. Tap on a task in the list to edit it.
2. Modify the task details and save.

### Filtering Tasks

1. Tap the filter button in the app bar.
2. Choose from the filter options (All, Completed, Incomplete) to update the task list.

### Sorting Tasks

1. Tap the sort button in the app bar.
2. Choose the sort order (Sort by Due Date Ascending or Descending).

### Marking Tasks as Complete/Incomplete

1. Tap the checkbox next to a task to toggle its completion status.

## Architecture

- **State Management**: Utilizes `flutter_bloc` for state management.
- **Local Storage**: Uses SQLite for persisting task data.
- **Navigation**: Implements navigation between task list, add task, and edit task screens.
- **Responsive Design**: Adapts UI elements to different screen sizes.
- **Animations**: Includes animations for transitions and list updates.

## Code Structure

- `lib/`: Contains the main codebase.
  - `cubit/`: Contains BLoC logic and state management.
    - `task_cubit.dart`: Manages tasks and their state.
    - `task_state.dart`: Defines the state for tasks.
  - `models/`: Contains data models.
    - `task.dart`: Defines the task model.
  - `repositories/`: Contains data access logic.
    - `task_repository.dart`: Provides methods to interact with the database.
  - `screens/`: Contains UI screens.
    - `task_list_screen.dart`: Displays the list of tasks.
    - `add_task_screen.dart`: UI for adding a new task.
    - `edit_task_screen.dart`: UI for editing an existing task.
  - `widgets/`: Contains reusable widgets.
    - `task_tile.dart`: Defines the task tile widget.
  - `utils/`: Contains utility functions and helpers.
    - `database_helper.dart`: Handles database operations.

## Acknowledgments

- Flutter team for providing an amazing framework.
- The community for resources and inspiration.
