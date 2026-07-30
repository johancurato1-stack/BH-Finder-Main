# 🏠 BH Finder

A modern boarding house finder application built with Flutter and Supabase.

BH Finder helps students discover nearby boarding houses, explore available rooms, save favorite properties, and communicate with landlords through a clean and intuitive mobile experience.

This project was built as a learning experience in Flutter architecture, backend development, and full-stack mobile application development.

---

## ✨ Features

### 👤 Tenant

- Browse boarding houses
- Search and filter properties
- View detailed property information
- Save favorite properties
- View available rooms
- Landlord profiles
- Property analytics (favorites & views)
- Authentication
- Responsive modern UI

### 🏠 Landlord

- Manage boarding houses
- Add and edit rooms
- Upload property images
- View property performance
- Monitor:
  - Total Views
  - Total Favorites
  - Total Rooms
  - Total Inquiries *(coming soon)*

### 🛡️ Admin

- Dashboard
- User management
- Property management
- Landlord verification
- Reports
- Feedback

---

## 🛠 Tech Stack

### Frontend

- Flutter
- Dart

### Backend

- Supabase
- PostgreSQL
- Row Level Security (RLS)
- Supabase Storage
- Authentication

### Architecture

Repository Pattern

```
UI
 ↓
Repository Interface
 ↓
Supabase Repository
 ↓
Supabase
```

---

## 📂 Project Structure

```
lib/

core/
roles/
shared/

```

The project separates:

- Core business logic
- Tenant features
- Landlord features
- Shared widgets
- Repositories
- View models

to keep the codebase maintainable and scalable.

---

## 🚀 Getting Started

### Requirements

- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Supabase Project

### Installation

```bash
git clone https://github.com/yourusername/bh_finder.git

cd bh_finder

flutter pub get
```

Run:

```bash
flutter run
```

---

## 🔐 Environment Variables

Create a `.env` file.

Example:

```env
SUPABASE_URL=YOUR_SUPABASE_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

Never commit your real keys.

---

## 📸 Screenshots

Coming soon.

---

## 📌 Roadmap

- [x] Tenant application
- [x] Landlord application
- [x] Admin panel
- [x] Favorites
- [x] Property analytics
- [x] Supabase backend
- [ ] Inquiry system
- [ ] Push notifications
- [ ] Maps improvements
- [ ] Production deployment

---

## 🤝 Contributing

Contributions are welcome.

Feel free to fork the repository, submit issues, or open pull requests.

---

## 📄 License

This project is licensed under the BH Finder Source-Available License.

The source code is provided for educational and evaluation purposes only. You may view the code and submit suggestions or pull requests, but you may not copy, modify, redistribute, or use this code in your own projects without prior written permission.

See the LICENSE file for full terms.

---

## 👨‍💻 Author

Johan Curato

Built with Flutter ❤️