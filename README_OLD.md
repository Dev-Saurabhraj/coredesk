# 🎯 CoreDesk - Enterprise HR Management Application

> A production-ready Flutter application for comprehensive HR management including attendance tracking, leave management, and employee profiles with an elegant, responsive design system.

**Version:** 1.0.0  
**Status:** Production Ready  
**Platform:** Android, iOS, Web, Windows, macOS, Linux

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [📸 Screenshots](#-screenshots)
- [APK Download](#-apk-download)
- [🚀 Installation Guide](#-installation-guide)
- [🏗️ Architecture Overview](#-architecture-overview)
- [🛠️ Technology Stack](#-technology-stack)
- [🎨 Key Features](#-key-features)
- [📱 Responsive Design](#-responsive-design)
- [🔑 Key Architectural Decisions](#-key-architectural-decisions)
- [📂 Project Structure](#-project-structure)
- [🧠 Application Logic](#-application-logic)
- [⚙️ Configuration & Setup](#-configuration--setup)
- [📊 State Management](#-state-management)
- [🌐 API Integration](#-api-integration)
- [🎯 Development Guidelines](#-development-guidelines)
- [📝 License](#-license)
- [👤 Author](#-author)

## 📖 Project Overview

**CoreDesk** is an enterprise-grade HR management mobile application built with **Flutter**, designed to streamline employee workflows through intuitive interfaces and robust functionality. The application follows **Clean Architecture** principles with clear separation between presentation, domain, and data layers, ensuring maintainability, scalability, and testability.

### What is CoreDesk?

CoreDesk is a comprehensive solution for HR teams and employees to manage:
- **Attendance Tracking** - Check-in/check-out with location tracking and work hours calculation
- **Leave Management** - Apply, approve, and track different types of leaves with status updates
- **Holiday Calendar** - View organizational holidays and upcoming celebrations
- **Dashboard Analytics** - Quick overview of attendance, leave balance, and pending requests
- **Employee Profile** - Manage personal information and view organizational details

### Key Statistics

| Metric | Value |
|--------|-------|
| **Responsive Design** | 360px to 1200px+ width support |
| **Supported Platforms** | Android, iOS, Web, Windows, macOS, Linux |
| **Architecture Pattern** | Clean Architecture + BLoC |
| **State Management** | Flutter BLoC with multi-page support |
| **API Integration** | Real-time data with pagination support |
| **Error Handling** | Comprehensive exception hierarchy with retry logic |
| **UI Framework** | Material Design 3 |
| **Code Organization** | Feature-based modular architecture |
| **Testing Ready** | Built-in mock data for testing pagination |

---

## 📸 Screenshots

> Add screenshots here to showcase the application UI

### 1. **Authentication Screen**
   - Email/Password login
   - Error handling and validation
   - Password visibility toggle

### 2. **Dashboard Screen**
   - Overview statistics (Attendance, Leaves, Requests)
   - Greeting card with user information
   - Recent leaves list with expandable view
   - Upcoming holidays calendar
   - Attendance summary

### 3. **Leaves Management Screen**
   - List of all leaves with pagination
   - Leave status indicators (Approved, Pending, Rejected)
   - Apply new leave functionality
   - Leave details and history
   - Filter by status

### 4. **Attendance Screen**
   - Daily attendance records with pagination
   🏗️ Architecture Overview

### Clean Architecture Pattern

CoreDesk follows **Clean Architecture** principles to ensure separation of concerns, making the codebase maintainable, testable, and scalable. The architecture is divided into three distinct layers:

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                       │
│  (UI, BLoC, Pages, Widgets, User Interactions)             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                           │
│  (Business Logic, Entities, Repositories, Use Cases)       │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                       DATA LAYER                            │
│  (API Services, Models, Repositories Implementation)        │
└─────────────────────────────────────────────────────────────┘
```

### Project Directory Structure

```
coredesk/
│
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── app.dart                           # App wrapper with routing
│   ├── index.dart                         # Main exports
│   │
│   ├── features/                          # Feature modules (independent and reusable)
│   │   ├── authentication/                # Login/Registration feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/          # API calls for auth
│   │   │   │   ├── models/               # Auth models (User, Login response)
│   │   │   │   └── repositories/         # Auth repository implementation
│   │   │   ├── domain/
│   │   │   │   ├── entities/             # Pure Dart entities
│   │   │   │   ├── repositories/         # Repository interfaces
│   │   │   │   └── usecases/             # Business logic (Login usecase)
│   │   │   └── presentation/
│   │   │       ├── bloc/                 # BLoC for state management
│   │   │       ├── pages/                # Login, Register pages
│   │   │       ├── widgets/              # Reusable auth widgets
│   │   │       └── index.dart
│   │   │
│   │   ├── dashboard/                    # Dashboard feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   ├── models/               # DashboardStatsModel, etc.
│   │   │   │   └── repositories/
│   │   │   ├── domain/
│   │   │   ├── presentation/
│   │   │   │   ├── bloc/                 # Dashboard state management
│   │   │   │   ├── pages/                # Home screen, dashboard page
│   │   │   │   ├── widgets/              # Stats cards, leave cards, holiday cards
│   │   │   │   ├── helpers/              # Helper functions
│   │   │   │   └── index.dart
│   │   │
│   │   ├── leaves/                       # Leave management feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   ├── models/
│   │   │   │   └── repositories/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       ├── pages/                # Leaves screen with pagination
│   │   │       ├── widgets/
│   │   │       └── bloc/
│   │   │
│   │   ├── attendance/                   # Attendance tracking feature
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   │       ├── pages/                # Attendance screen with pagination
│   │   │       ├── widgets/
│   │   │       └── bloc/
│   │   │
│   │   └── profile/                      # Employee profile feature
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   │
│   ├── core/                             # Core functionality shared across app
│   │   ├── network/
│   │   │   ├── dio_client.dart          # HTTP client with retry logic
│   │   │   ├── mock_api_data.dart       # Mock data for testing (20+ entries each)
│   │   │   └── api_endpoints.dart       # API endpoint constants
│   │   │
│   │   ├── exceptions/
│   │   │   └── exceptions.dart          # Custom exception hierarchy
│   │   │
│   │   ├── responsive/
│   │   │   ├── responsive_system.dart   # Device-aware responsive system
│   │   │   ├── responsive_extensions.dart
│   │   │   └── responsive_widgets.dart
│   │   │
│   │   ├── theme/
│   │   │   ├── app_theme.dart           # Material 3 theme
│   │   │   └── dark_theme.dart
│   │   │
│   │   ├── colors/
│   │   │   └── app_colors.dart          # Color constants
│   │   │
│   │   ├── constants/
│   │   ├── utils/
│   │   ├── apiServices/
│   │   └── index.dart
│   │
│   ├── shared/                           # Shared widgets and services
│   │   ├── widgets/
│   │   │   ├── app_bottom_navigation_bar.dart
│   │   │   ├── error_widgets.dart
│   │   │   ├── responsive_widgets.dart
│   │   │   └── ...
│   │   ├── services/
│   │   │   └── haptics_service.dart
│   │   └── providers/
│   │
│   ├── config/
│   │   └── dependencies.dart             # Dependency injection setup
│   │
│   ├── routes/
│   │   └── app_routes.dart              # LazyBox routing
│   │
│   └── index.dart
│
├── assets/                               # Static assets
│   ├── AppLogo/
│   ├── Icons/
│   └── Images/
│
├── android/                              # Android native code
├── ios/                                  # iOS native code
├── web/                                  # Web build files
├── windows/                              # Windows build files
├── macos/                                # macOS build files
├── linux/                                # Linux build files
│
├── test/                                 # Unit and widget tests
│
├── pubspec.yaml                          # Project dependencies
├── pubspec.lock
├── analysis_options.yaml                 # Linter rules
├── devtools_options.yaml
│
└── README.md                             # This file
```

### Layer Responsibilities

#### 1️⃣ **Presentation Layer** (UI & Interaction)
**Location:** `lib/features/*/presentation/`

Handles all user interface and interaction:
- **BLoCs:** Manage state using the Business Logic Component pattern
- **Pages:** Full-screen widgets representing routes
- **Widgets:** Reusable UI components
- **Responsive System:** Adaptive layouts for different screen sizes

**Example - Dashboard Feature:**
```
presentation/
├── bloc/
│   ├── dashboard_bloc.dart        # State management
│   ├── dashboard_event.dart       # User actions
│   └── dashboard_state.dart       # State definitions
├── pages/
│   └── dashboard_page.dart        # Main screen
├── widgets/
│   ├── stats_grid.dart            # Stats display
│   ├── leave_card.dart            # Leave item
│   └── holiday_card.dart          # Holiday item
└── helpers/
    └── dashboard_helper.dart      # Helper functions
```

#### 2️⃣ **Domain Layer** (Business Logic)
**Location:** `lib/features/*/domain/`

Contains pure business logic independent of any framework:
- **Entities:** Core data structures
- **Repositories:** Interface contracts
- **UseCases:** Business logic operations

**Example:**
```dart
// Entity
class Leave {
  final String id;
  final String type;
  final DateTime startDate;
  final String status;
  // ...
}

// Repository Interface
abstract class LeaveRepository {
  Future<List<Leave>> getLeaves({int page, int limit});
}

// Use Case
class GetLeavesUseCase {
  final LeaveRepository repository;
  Future<List<Leave>> call({int page = 1, int limit = 10}) {
    return repository.getLeaves(page: page, limit: limit);
  }
}
```

#### 3️⃣ **Data Layer** (Network & Storage)
**Location:** `lib/features/*/data/`

Manages data sources and implementations:
- **DataSources:** API calls, local storage
- **Models:** JSON serialization with `fromJson`/`toJson`
- **Repositories:** Implementation of domain interfaces

**Example:**
```dart
// Model (with serialization)
class LeaveModel extends Leave {
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
   📂 Project Structure

### Core Technologies

| Category | Technology | Version | Purpose |
|----------|-----------|---------|---------|
| **Language** | Dart | 3.11.4+ | Primary programming language |
| **Framework** | Flutter | 3.11.4+ | Cross-platform UI framework |
| **State Mgmt** | BLoC | 9.0.0+ | Business Logic Component pattern |
| **HTTP Client** | Dio | 5.4.0 | API requests with retry logic |
| **Routing** | GoRouter | 17.2.0 | Navigation and deep linking |
| **Storage** | SharedPreferences | 2.2.2 | Local key-value storage |
| **Serialization** | Equatable | 2.0.8 | Value equality in Dart |
| **UI Design** | Material 3 | Built-in | Modern design system |
| **Fonts** | Google Fonts | 8.0.2 | Custom typography |
| **Icons** | Flutter Icons | 1.0.8 | Material UI icons |
| **Shimmer** | Shimmer | 3.0.0 | Loading skeleton screens |
| **Localization** | Intl | 0.19.0 | Date/time formatting |
| **Service Locator** | GetIt | 7.6.0 | Dependency injection |
| **Linting** | Flutter Lints | 6.0.0 | Code quality standards |
| **Icon Generation** | Flutter Launcher Icons | 0.13.1 | App icon generation |

### Architecture & Design Patterns

- **Clean Architecture:** Separation of concerns into layers
- **BLoC Pattern:** State management with events and states
- **Repository Pattern:** Abstraction of data sources
- **Singleton Pattern:** Shared services via GetIt
- **Responsive Design:** Device-aware UI system
- **Dependency Injection:** Loose coupling and testability

### API & Networking

- **Base URL:** Configurable API endpoint (mock data for testing)
- **Timeout:** 15s connection, 30s receive timeout
- **Retry Logic:** Exponential backoff (3 retries)
- **Error Handling:** Custom exception hierarchy
- **Pagination:** Page-based with configurable limits
- **Mock Data:** 20+ entries each for testing

### Database & Storage

- **Local Storage:** SharedPreferences for user preferences
- **Cache Strategy:** Manual cache management
- **Session Management:** Token-based authentication

---

## 🎨 Key Features

### 1. **Dashboard Overview**
- Real-time statistics (Attendance count, Leave balance, Pending requests)
- Quick access to recent activities
- Expandable sections for leaves and holidays
- One-tap navigation to detailed screens
- Refresh capability with pull-to-refresh

### 2. **Attendance Management**
- ✅ Daily attendance records
- 📍 Location tracking (Office/Remote/Client Site)
- ⏰ Check-in/Check-out times
- 📊 Work hours calculation
- 📄 Attendance history with pagination (20+ records)
- 🔍 Status indicators (Present, Absent, Half Day, Leave)

### 3. **Leave Management**
- 📝 Apply new leave request
- 📋 View all leave records with pagination (20+ entries)
- ✅ Track leave status (Approved, Pending, Rejected)
- 📅 Multiple leave types (Casual, Sick, Earned, Maternity, etc.)
- 👤 Approval tracking (who approved)
- 📊 Leave balance and history

### 4. **Holiday Calendar**
- 🎉 Organization-wide holiday listing
- 📅 Holiday dates and names
- 🔔 Holiday reminders
- 📍 Location-specific holidays (if applicable)

### 5. **User Authentication**
- 🔐 Secure email/password login
- ✔️ Input validation
- 📧 Remember me functionality
- 🔓 Logout with token cleanup
- 🛡️ Token-based authentication

### 6. **Employee Profile**
- 👤 Personal information display
- 🏢 Department and role details
- 📞 Contact information
- 📸 Avatar/Profile picture
- ✏️ Edit profile capability
- 🔔 Notification preferences

### 7. **Responsive Design System**
- 📱 Mobile: 360px+ devices
- 📱 Tablets: 600px+ devices
- 🖥️ Desktop: 1200px+ devices
- 🎯 Adaptive spacing and padding
- 📏 Flexible typography
- 🎨 Dynamic color system

---

## 📱 Responsive Design

CoreDesk implements a sophisticated responsive system that adapts to any screen size:

### Device Categories

| Category | Width Range | Examples |
|----------|-------------|----------|
| **Extra Small** | 320-480px | Old phones |
| **Small** | 480-600px | Modern phones (portrait) |
| **Medium** | 600-900px | Tablets, phones (landscape) |
| **Large** | 900px+ | Tablets, desktops |

### Using Responsive System

```dart
// Access responsive utilities
final padding = context.responsive.horizontalPadding();
final fontSize = context.adaptiveFont.bodyLarge();
final deviceType = context.deviceCategory;

// Conditional rendering
if (context.isMediumScreen) {
  // Tablet layout
} else {
  // Mobile layout
}
```

### Responsive Widgets

- `ResponsiveWidget` - Device-based widget switching
- `ResponsivePaddingContainer` - Auto padding
- `ResponsiveGrid` - Auto-layout grid
- `FittedSpacing` - Adaptive spacing

---

## 🔑 Key ArchitecturalveModel(
      id: json['id'],
      type: json['type'],
      // ...
    );
  }
}

// Data Source
class LeaveRemoteDataSource {
  Future<List<LeaveModel>> getLeaves(int page, int limit) {
    return dioClient.get('/leaves', 
      queryParameters: {'page': page, 'limit': limit}
    );
  }
}

// Repository Implementation
class LeaveRepositoryImpl extends LeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;
  
  @override
  Future<List<Leave>> getLeaves({int page = 1, int limit = 10}) {
    return remoteDataSource.getLeaves(page, limit);
  }
}
```

#### 4️⃣ **Core Layer** (Cross-cutting Concerns)
**Location:** `lib/core/`

Shared utilities used across all features:
- **Network:** HTTP client with retry logic and pagination
- **Exceptions:** Unified error handling
- **Responsive:** Device-aware UI system
- **Theme:** Design system and colors
- **Dependencies:** Service locator setup

#### 5️⃣ **Shared Layer** (Reusable Components)
**Location:** `lib/shared/`

Widgets and services used across multiple features:
- **Widgets:** Common UI components (buttons, cards, dialogs)
- **Services:** Haptics, notifications, analytics
- **Providers:** Global state provider
```

**For Specific Device:**
```bash
flutter run -d <device-id>
```

**With Performance Monitoring:**
```bash
flutter run --profile
```

#### Step 5: Build for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (Google Play):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

---

### Troubleshooting Installation

| Issue | Solution |
|-------|----------|
| **Gradle build fails** | Run `flutter clean` and `flutter pub get` again |
| **Pod install errors (iOS)** | Run `cd ios && pod repo update && pod install && cd ..` |
| **Device not detected** | Run `flutter devices` to list connected devices |
| **Permission denied** | Run `chmod +x gradlew` in Android directory |
| **Java version mismatch** | Ensure JDK 11+ is installed and set in JAVA_HOME |

## Architecture Overview

### Clean Architecture Layers

```
lib/
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── providers/
│   ├── dashboard/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       ├── widgets/
│   │       ├── helpers/
│   │       └── providers/
│   ├── leaves/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── attendance/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── core/
│   ├── apiServices/
│   ├── exceptions/
│   ├── network/
│   ├── theme/
│   ├── colors/
│   ├── utils/
│   └── constants/
├── shared/
│   ├── widgets/
│   ├── services/
│   └── providers/
└── config/
    └── dependencies.dart
```

### Layer Responsibilities

**Presentation Layer (UI):**
- BLoC for state management
- Pages and custom widgets
- User interaction handling
- Responsive design implementation

**Domain Layer (Business Logic):**
- Entity definitions
- Repository interfaces
- Use cases encapsulating business rules
- Independent of frameworks

**Data Layer (Network & Storage):**
- API data sources
- Model serialization/deserialization
- Repository implementations
- Error handling and data transformation

### Data Flow

```
UI (BLoC) 
    ↓
Use Cases (Domain)
    ↓
Repositories (Data)
    ↓
Data Sources (Network/Local)
    ↓
API/Database
```

## Development Decisions

### 1. State Management: BLoC Pattern

**Decision:** Use Provider + BLoC for state management instead of GetX or Riverpod.

**Rationale:**
- Industry standard with large community support
- Excellent testability and separation of concerns
- Predictable state transitions
- Works seamlessly with Flutter ecosystem

**Implementation:**
- `DashboardBloc` manages dashboard data and state transitions
- Event-driven architecture ensures clear action triggers
- Emit states for UI rebuilds with minimal overhead

### 2. Architecture: Clean Architecture

**Decision:** Implement strict Clean Architecture with three layers.

**Rationale:**
- High maintainability and testability
- Framework-independent business logic
- Easy to locate features and debug issues
- Scales well with team growth

**Implementation:**
- Feature modules follow feature-first structure
- Each feature has independent data, domain, and presentation layers
- Shared components in `core` and `shared` folders
- Dependency injection via constructor injection

### 3. Responsive Design: Modular System

**Decision:** Create centralized responsive helpers with breakpoints and adaptive sizing.

**Rationale:**
- Single source of truth for responsive configurations
- Consistent scaling across all screens
- Easy to maintain and update
- Eliminates scattered MediaQuery calls

**Core Components:**
- `ResponsiveBreakpoints`: Device size categories (extraSmall, small, medium, large)
- `DeviceSize` enum: Runtime device classification
- `ResponsivePadding`: Spacing constants that adapt to screen size
- `AdaptiveFont`: Responsive typography system
- `ResponsiveSpacing`: Unified margin and padding utilities

### 4. Error Handling: Comprehensive Strategy

**Decision:** Multi-layer error handling with specific exception types.

**Rationale:**
- User-friendly error messages
- Proper logging for debugging
- Graceful degradation
- Recovery mechanisms

**Hierarchy:**
- Custom exceptions (AuthException, ServerException, NetworkException)
- Bloc error states with retry mechanisms
- User feedback via snackbars and dialogs
- Fallback UI for error states

### 5. API Integration: Resilience & Retry Logic

**Decision:** DioClient wrapper with interceptors and retry policies.

**Rationale:**
- Handles network timeouts gracefully
- Automatic token refresh for authentication
- Request/response logging
- Rate limiting support

**Features:**
- Exponential backoff retry strategy
- Connection timeout: 15 seconds
- Receive timeout: 30 seconds
- Request cancellation support

### 6. Design System: Ethereal Professional

**Decision:** Custom Material Design 3 implementation with premium aesthetics.

**Rationale:**
- Consistent, polished UI across all screens
- Accessibility compliance
- Modern glassmorphism and atmospheric elements
- Professional brand presentation

**Key Characteristics:**
- Electric Indigo primary color (#1E3A8A)
- 24px (XL) border radius for main containers
- 12px (MD) border radius for nested elements
- Ambient shadows only, no hard borders
- 60% opacity with 20-40px blur for glassmorphism

### 7. Feature Organization: Feature-First Structure

**Decision:** Organize code by feature rather than by layer type.

**Rationale:**
- Easy feature isolation and reusability
- Reduces cognitive load when working on features
- Facilitates independent team work
- Simplifies feature removal or replacement

**Features:**
- `authentication`: Login and authentication flows
- `dashboard`: Main dashboard with statistics
- `leaves`: Leave management and tracking
- `attendance`: Attendance records and logs
- `profile`: User profile and settings

### 8. Dependency Injection: Constructor-Based

**Decision:** Use constructor injection with service locator pattern.

**Rationale:**
- Easy testing with mock objects
- Clear dependencies visibility
- No magic or reflection overhead
- Framework-agnostic approach

**Implementation:**
- Dependencies configured in `config/dependencies.dart`
- Repositories injected into Use Cases
- Use Cases injected into BLoCs
- Services injected into Repositories

### 9. Code Organization: No Comments

**Decision:** Code is self-documenting through clear naming and structure.

**Rationale:**
- More maintainable, self-explanatory code
- Less risk of outdated comments
- Developers forced to write clearer code
- Focus on meaningful names and structure

## Project Structure Details

### Core Module

```
core/
├── apiServices/         # API endpoints and configurations
├── colors/              # Color palette and theme
├── exceptions/          # Custom exception types
├── network/             # Network client and interceptors
├── theme/               # Theme data and styling
├── styles/              # Text styles and decorations
└── utils/               # Utility functions
```

### Shared Module

```
shared/
├── widgets/             # Reusable UI components
├── services/            # Shared business services
└── providers/           # Shared state providers
```

## Key Features

### Authentication
- Secure login with token management
- Session persistence
- Automatic token refresh
- Logout with cleanup

### Dashboard
- Real-time statistics overview
- Leave and attendance summaries
- Holiday calendar
- Quick action buttons
- Expandable sections for detailed views

### Leave Management
- Leave request creation and tracking
- Leave balance display
- Leave history with status indicators
- Approval workflow integration

### Attendance
- Daily attendance records
- Check-in/check-out times
- Status indicators (present, absent, half-day)
- Attendance history with filters

### Profile Management
- User profile information
- Settings and preferences
- Security settings
- Help and support

### Responsive Design
- Supports all device sizes from 360px to 1200px+
- Adaptive layout adjustments
- Touch-friendly interface
- Portrait and landscape modes

## Technology Stack

### Frontend
- **Flutter 3.x**: Cross-platform framework
- **Dart 3.x**: Programming language
- **Provider**: Dependency injection
- **flutter_bloc**: State management
- **go_router**: Navigation routing
- **dio**: HTTP networking
- **shimmer**: Loading states
- **equatable**: Value equality

### Architecture & Design Patterns
- Clean Architecture (Domain, Data, Presentation)
- BLoC Pattern for state management
- Repository Pattern for data abstraction
- Singleton Pattern for services

### Utilities
- **GetIt**: Service locator
- **Equatable**: Value object comparison

## Error Handling Strategy

### Exception Types

```
AppException (base)
├── AuthException          # Authentication errors
├── ServerException        # Server errors (5xx)
├── ClientException        # Client errors (4xx)
├── NetworkException       # Network connectivity
├── TimeoutException       # Request timeouts
├── CacheException         # Cache operations
└── UnknownException       # Unexpected errors
```

### Error Recovery

1. **Network Errors**: Automatic retry with exponential backoff
2. **Auth Errors**: Token refresh or logout flow
3. **Server Errors**: User-friendly messages with retry option
4. **Validation Errors**: Field-level error display
5. **Timeout Errors**: Retry mechanism with longer timeout

## Responsive Design System

### Breakpoints

- **Extra Small**: < 360px (old phones)
- **Small**: 360-480px (phones)
- **Medium**: 480-720px (large phones)
- **Large**: 720px+ (tablets, desktops)

### Responsive Values

All sizing, spacing, and typography adapt based on device category:
- Padding: 12-18px horizontal, adaptive vertical
- Border radius: 12-24px based on component
- Font sizes: 12-32px scaling
- Icon sizes: 16-24px adaptive
- Touch targets: Minimum 44x44dp

## Performance Optimizations

- Lazy loading of screens and images
- Efficient list rendering with `ListView.builder`
- Image caching and optimization
- Reduced rebuilds through Provider/BLoC
- Memory-efficient state management
- Minimal widget tree depth

## Testing Strategy

### Unit Tests
- Repository implementations
- Use cases and business logic
- BLoC state transitions
- Utility functions

### Widget Tests
- Custom widgets and components
- Responsive behavior verification
- User interaction flows

### Integration Tests
- End-to-end user flows
- API integration points
- Navigation flows

## Deployment

### Pre-Release Checklist
- [ ] All tests passing
- [ ] No console warnings or errors
- [ ] Performance profiling completed
- [ ] Security review done
- [ ] App signing configured
- [ ] Version numbers updated

### Release Process
- Build release APK/IPA
- Submit to stores (Google Play, Apple App Store)
- Monitor crash reports and user feedback
- Plan regression testing

## Contributing

1. Create feature branch: `git checkout -b feature/feature-name`
2. Commit changes: `git commit -m 'Add feature'`
3. Push to branch: `git push origin feature/feature-name`
4. Open a pull request

## Troubleshooting

### Common Issues

**Issue**: API requests failing
- **Solution**: Check internet connectivity, verify API endpoints, check token validity

**Issue**: UI not responsive
- **Solution**: Verify breakpoint configuration, check MediaQuery usages, test on different devices

**Issue**: State not updating
- **Solution**: Check BLoC events are triggered, verify state emission, check listener setup

## License

This project is proprietary software. All rights reserved.

## Contact & Support

For support or questions, contact: support@coredesk.dev

---

**Last Updated**: April 2026
**Version**: 1.0.0
**Status**: Production Ready
