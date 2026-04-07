# CoreDesk - HR Management Application

A modern Flutter application for comprehensive HR management including attendance tracking, leave management, and employee profiles with an elegant, responsive design system.

## Table of Contents

- [Project Overview](#project-overview)
- [Setup Instructions](#setup-instructions)
- [Architecture Overview](#architecture-overview)
- [Development Decisions](#development-decisions)
- [Project Structure](#project-structure)
- [Key Features](#key-features)
- [Technology Stack](#technology-stack)

## Project Overview

CoreDesk is a feature-rich HR management mobile application built with Flutter, designed to streamline employee workflows through intuitive interfaces and robust functionality. The application follows Clean Architecture principles with clear separation between presentation, domain, and data layers.

**Key Statistics:**
- Responsive design supporting devices from 360px to 1200px+ width
- Modular architecture with independent feature modules
- BLoC pattern for state management
- Comprehensive error handling and API resilience
- Accessible UI following Material Design 3 principles

## Setup Instructions

### Prerequisites

- Flutter SDK: 3.x or higher
- Dart SDK: 3.x or higher
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Dev-Saurabhraj/coredesk.git
   cd coredesk
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate API Models (if using code generation)**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the Application**
   ```bash
   flutter run
   ```

### Build for Release

- **Android:**
  ```bash
  flutter build apk --release
  ```

- **iOS:**
  ```bash
  flutter build ios --release
  ```

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
