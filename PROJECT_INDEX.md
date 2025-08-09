# Hui Application - Project Index

## 📋 Tổng quan dự án

Hui Application là một hệ thống quản lý "Hụi" (ROSCA - Rotating Savings and Credit Association) với kiến trúc full-stack:

- **Frontend**: Flutter app cross-platform (Android, iOS, Web, Windows, Linux, macOS)
- **Backend**: Node.js API với Fastify và MongoDB
- **Mục đích**: Quản lý các nhóm tiết kiệm luân phiên, kết nối người dùng

---

## 🏗️ Cấu trúc dự án

### Frontend (`hui_application/`)

#### 📱 Flutter App Structure
```
lib/
├── core/                    # Core utilities & configurations
│   ├── config/             # App configuration
│   ├── constants/          # Constants & endpoints
│   ├── forms/              # Form handling
│   ├── guards/             # Route guards
│   ├── network/            # API client & networking
│   ├── providers/          # State management (Riverpod)
│   ├── services/           # Core services
│   ├── utils/              # Utility functions
│   └── validators/         # Form validators
├── features/               # Feature modules
│   ├── account/            # User account management
│   ├── auth/               # Authentication
│   ├── discovery/          # Discovery features
│   ├── groups/             # Group management
│   └── home/               # Home screen
├── models/                 # Data models
├── routes/                 # Navigation & routing
├── screens/                # UI screens
├── theme/                  # App theming
├── widgets/                # Reusable widgets
├── main.dart               # App entry point
└── platform_app.dart       # Platform-specific app setup
```

#### 🎨 UI/UX Features
- **Design System**: Material Design + Cupertino + Fluent UI
- **Theming**: Light/Dark mode support
- **Localization**: Multi-language (English, Vietnamese)
- **Custom Fonts**: BeVietnamPro, Inter
- **Animations**: Lottie animations, custom loading states

#### 🔧 Core Technologies
- **State Management**: Riverpod
- **Navigation**: Go Router
- **Networking**: Dio HTTP client
- **Authentication**: Firebase Auth
- **Forms**: Reactive Forms
- **Localization**: Flutter Intl
- **Code Generation**: Freezed, JSON serializable

### Backend (`hui-api/`)

#### 🚀 API Structure
```
src/
├── config/                 # Configuration
├── lib/                    # Core libraries
├── locales/                # Internationalization
├── middlewares/            # Request middlewares
├── models/                 # Database models
├── plugins/                # Fastify plugins
├── routes/                 # API routes
├── schemas/                # Zod validation schemas
├── types/                  # TypeScript types
├── utils/                  # Utility functions
└── index.ts                # Server entry point
```

#### 🔧 Core Technologies
- **Runtime**: Node.js
- **Framework**: Fastify
- **Database**: MongoDB
- **Authentication**: Lucia Auth + JWT
- **Validation**: Zod
- **Documentation**: Swagger/OpenAPI
- **Security**: Argon2 password hashing

---

## 🚀 Cách chạy dự án

### Frontend (Flutter)

```bash
# 1. Cài đặt dependencies
cd hui_application
flutter pub get

# 2. Tạo file .env với các biến môi trường
# ENV=development
# FIREBASE_API_KEY=your_firebase_api_key
# FIREBASE_PROJECT_ID=your_project_id

# 3. Chạy ứng dụng
flutter run

# 4. Build cho production
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

### Backend (Node.js)

```bash
# 1. Cài đặt dependencies
cd hui-api
npm install

# 2. Tạo file .env với các biến môi trường
# PORT=3000
# MONGODB_URI=mongodb://localhost:27017/hui
# JWT_SECRET=your_jwt_secret

# 3. Chạy development server
npm run dev

# 4. Build và chạy production
npm run build
npm start
```

---

## 📚 API Documentation

### Base URL
- **Development**: `http://localhost:3000`
- **Production**: `https://your-api-domain.com`

### Swagger Documentation
- **URL**: `http://localhost:3000/docs`
- **Authentication**: JWT token required for most endpoints

### Main Endpoints

#### Authentication
- `POST /auth/register` - Đăng ký người dùng mới
- `POST /auth/login` - Đăng nhập và lấy token

#### Users
- `GET /users` - Danh sách người dùng
- `GET /users/:id` - Chi tiết người dùng
- `PATCH /users/:id` - Cập nhật thông tin người dùng

#### Groups (Hụi)
- `GET /groups` - Danh sách nhóm
- `POST /groups` - Tạo nhóm mới
- `PATCH /groups/:id` - Cập nhật thông tin nhóm
- `POST /groups/:id/join` - Tham gia nhóm

#### Group Members
- `GET /groups/:id/members` - Danh sách thành viên nhóm

#### Friendships
- Quản lý kết nối giữa người dùng

---

## 🛠️ Development Tools

### Code Generation
```bash
# Flutter code generation
flutter packages pub run build_runner build
flutter packages pub run build_runner watch

# Generate assets
flutter packages pub run flutter_gen_runner
```

### Linting & Formatting
```bash
# Flutter
flutter analyze
dart format .

# Backend
npm run lint
npm run format
```

### Database
- **MongoDB**: Main database
- **Collections**: users, groups, groupMembers, friendships, roles

---

## 📱 Features

### User Management
- ✅ Đăng ký/Đăng nhập với Firebase Auth
- ✅ Quản lý profile người dùng
- ✅ Hệ thống friendship
- ✅ Multi-language support

### Group Management
- ✅ Tạo và quản lý nhóm Hụi
- ✅ Tham gia/rời nhóm
- ✅ Quản lý thành viên
- ✅ Tracking contributions

### UI/UX
- ✅ Cross-platform support
- ✅ Responsive design
- ✅ Dark/Light theme
- ✅ Custom animations
- ✅ Form validation

### Security
- ✅ JWT authentication
- ✅ Password hashing (Argon2)
- ✅ Password strength validation
- ✅ Route guards

---

## 🔧 Configuration

### Environment Variables

#### Frontend (.env)
```env
ENV=development
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_PROJECT_ID=your_project_id
```

#### Backend (.env)
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/hui
JWT_SECRET=your_jwt_secret
NODE_ENV=development
```

### Firebase Setup
1. Tạo project trên Firebase Console
2. Thêm ứng dụng Android/iOS/Web
3. Tải file `google-services.json` cho Android
4. Cấu hình iOS với `GoogleService-Info.plist`

---

## 📦 Dependencies

### Frontend (pubspec.yaml)
- **State Management**: `flutter_riverpod`, `riverpod`
- **Navigation**: `go_router`
- **Networking**: `dio`
- **Authentication**: `firebase_auth`, `firebase_core`
- **UI**: `fluent_ui`, `flutter_spinkit`, `lottie`
- **Forms**: `reactive_forms`, `pin_code_fields`
- **Localization**: `intl`, `flutter_localizations`

### Backend (package.json)
- **Framework**: `fastify`
- **Database**: `mongodb`, `@fastify/mongodb`
- **Authentication**: `lucia`, `@lucia-auth/adapter-mongodb`
- **Validation**: `zod`, `fastify-type-provider-zod`
- **Security**: `argon2`, `zxcvbn`
- **Documentation**: `@fastify/swagger`, `@fastify/swagger-ui`

---

## 🚀 Deployment

### Frontend
- **Android**: Google Play Store
- **iOS**: App Store
- **Web**: Firebase Hosting
- **Desktop**: Windows Store, Mac App Store

### Backend
- **Platform**: Fly.io (configured with `fly.toml`)
- **Database**: MongoDB Atlas
- **Environment**: Production environment variables

---

## 📝 Development Notes

### Code Style
- **Flutter**: Follow Flutter linting rules
- **Backend**: ESLint + Prettier
- **TypeScript**: Strict mode enabled

### Git Workflow
1. Feature branches from `main`
2. Pull requests for code review
3. Automated testing (to be implemented)
4. Deployment to staging/production

### Performance
- **Frontend**: Lazy loading, image caching
- **Backend**: Connection pooling, query optimization
- **Database**: Indexed queries, efficient schemas

---

## 🔗 Links

- **Repository**: [GitHub Repository]
- **API Documentation**: `http://localhost:3000/docs`
- **Firebase Console**: [Firebase Project]
- **MongoDB Atlas**: [Database Dashboard]

---

## 📞 Support

- **Issues**: GitHub Issues
- **Documentation**: README files in each directory
- **API Docs**: Swagger UI when server is running

---

*Last updated: [Current Date]*
*Version: 1.0.0* 