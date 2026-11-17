# BH Finder

A boarding-house discovery and management platform built with Flutter and Supabase, designed to help students find accommodation and help landlords manage their properties.

BH Finder provides mobile experiences for tenants and landlords, with features for property discovery, room management, favorites, property analytics, and backend integration.

This project was developed as an independent software development project, with an emphasis on clean architecture, maintainable code, and practical application development.

## Application Screenshots

### Tenant Application

|                    Home                     |                     Search                      |
| :-----------------------------------------: | :---------------------------------------------: |
| ![Tenant Home](screenshots/tenant-home.png) | ![Tenant Search](screenshots/tenant-search.png) |

|                   Property Details                    |                 Room Details                  |
| :---------------------------------------------------: | :-------------------------------------------: |
| ![Property Details](screenshots/property-details.png) | ![Room Details](screenshots/room-details.png) |

### Landlord Application

|                         Dashboard                         |                         Properties                          |
| :-------------------------------------------------------: | :---------------------------------------------------------: |
| ![Landlord Dashboard](screenshots/landlord-dashboard.png) | ![Landlord Properties](screenshots/landlord-properties.png) |

## Features

### Tenant

- Browse boarding-house properties
- Search and filter properties
- View detailed property information
- Browse available rooms and room details
- Save properties to favorites
- View landlord information
- View property details and analytics where available
- User authentication

### Landlord

- Manage boarding-house properties
- Add and manage rooms
- Upload property and room images
- View property performance statistics
- Monitor property views and favorites

### Application Architecture

BH Finder follows a layered architecture using the Repository Pattern and Provider for state management.

The application separates presentation, application logic, and data access to improve maintainability and make the codebase easier to extend.

**Data flow:**

```text
UI
 ↓
ViewModel
 ↓
Repository Interface
 ↓
Supabase Repository
 ↓
Supabase
```

## Technology Stack

| Category           | Technologies             |
| ------------------ | ------------------------ |
| Mobile Development | Flutter, Dart            |
| State Management   | Provider                 |
| Backend            | Supabase                 |
| Database           | PostgreSQL               |
| Authentication     | Supabase Auth            |
| Storage            | Supabase Storage         |
| Database Security  | Row Level Security (RLS) |
| Version Control    | Git, GitHub              |

## Project Structure

```text
lib/
├── core/
│   ├── config/
│   ├── models/
│   └── ...
├── roles/
│   ├── tenant/
│   └── landlord/
├── shared/
└── ...
assets/
android/
ios/
web/
windows/
linux/
macos/
```

The project is organized around core application components, role-specific functionality, and shared resources.

## Getting Started

### Prerequisites

Before running the application, make sure you have:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Git
- A Supabase project

### Installation

1. Clone the repository:

```bash
git clone https://github.com/johancurato1-stack/BH-Finder-Main.git
```

2. Navigate to the project directory:

```bash
cd BH-Finder-Main
```

3. Install dependencies:

```bash
flutter pub get
```

4. Configure your Supabase project.

Open:

```text
lib/core/config/supabase_config.dart
```

Configure the Supabase project URL and publishable key for your own Supabase project.

5. Run the application:

```bash
flutter run
```

### Supabase Configuration

BH Finder uses Supabase for authentication, database operations, and file storage.

To run your own instance, you will need to configure the required Supabase tables, storage buckets, authentication settings, and Row Level Security policies.

**Security note:** Only use a Supabase publishable key in client-side application code. Never expose a Supabase secret or service-role key. Ensure that appropriate Row Level Security policies are configured before using the application.

## Project Status

BH Finder is an actively developed project. Its tenant application, landlord application, and web-based admin panel have been implemented, with Supabase providing backend services and data management.

Some features and refinements may still be ongoing.

## License

BH Finder is distributed under a custom restricted, source-available license.

The repository is publicly accessible for educational and evaluation purposes. Viewing and studying the source code is permitted, but copying, modifying, redistributing, or incorporating the code into other projects requires prior written permission.

See [LICENSE.md](LICENSE.md) for the complete terms.

## Author

**Johan Curato**

GitHub: [@johancurato1-stack](https://github.com/johancurato1-stack)
