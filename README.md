# todo_task

Project Structure
 This project follows the MVVM (Model-View-ViewModel) architecture. Here’s a quick overview of the structure:

# lib
 data: Manages data retrieval, storage, and APIs.
 domain: Contains business logic and entity models.
 presentation: Handles UI and state management.
 Data Layer
 Responsible for data management, including:

# Repositories: Interfaces for data access.
 Data Sources: Concrete implementations for data access (e.g., APIs, local databases).
 Models: Data models for serialization and deserialization.
 Domain Layer
 Encapsulates business logic, including:

## Use Cases: Classes that represent application-specific business rules.
 Entities: Core objects used across the application.
 
# Presentation Layer
 Handles UI and state management, including:

View Models: Manage UI-related data and handle user interaction.
Widgets: Flutter widgets for rendering the user interface.
Features
Authentication: User login and registration.
Task Management: CRUD operations for tasks.
State Management: Implemented using a Flutter state management solution (Bloc, Cubit).

# Test
 Bloc Unit Test
 Repo Unit Test
