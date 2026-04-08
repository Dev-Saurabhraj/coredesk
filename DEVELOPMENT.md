# CoreDesk Development Guidelines

This document provides comprehensive guidelines for using the modular responsive system, error handling, and architecture patterns in CoreDesk.

## Responsive System Usage

### 1. Using ResponsiveSystem in Widgets

```dart
import 'package:coredesk/core/responsive/responsive_extensions.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.horizontalPadding(),
        vertical: responsive.verticalPadding(),
      ),
      child: Text('Responsive text'),
    );
  }
}
```

### 2. Adaptive Font System

All text should use the adaptive font system to ensure responsiveness:

```dart
Text(
  'Large Title',
  style: TextStyle(
    fontSize: context.adaptiveFont.headlineLarge(),
    fontWeight: FontWeight.bold,
  ),
)
```

Font sizing hierarchy:
- `displayLarge()` / `displayMedium()` / `displaySmall()` - For hero sections
- `headlineLarge()` / `headlineMedium()` / `headlineSmall()` - For page headers
- `titleLarge()` / `titleMedium()` / `titleSmall()` - For card titles
- `bodyLarge()` / `bodyMedium()` / `bodySmall()` - For body text
- `labelLarge()` / `labelMedium()` / `labelSmall()` - For labels and buttons

### 3. Icon Sizing

```dart
Icon(
  Icons.home,
  size: context.responsive.iconSizeSmall(),
)
```

Available icon sizes:
- `iconSizeXSmall()` - 16-22dp
- `iconSizeSmall()` - 20-28dp
- `iconSizeMedium()` - 28-36dp
- `iconSizeLarge()` - 40-56dp

### 4. Device Categories

Always check device category instead of raw screen width:

```dart
if (context.deviceCategory == DeviceCategory.large) {
  // Tablet/Desktop layout
} else {
  // Mobile layout
}
```

### 5. Spacing Constants

Use the unified spacing system:

```dart
Column(
  children: [
    Text('Title'),
    SizedBox(height: context.sectionSpacing), // 16-24dp
    Text('Content'),
    SizedBox(height: context.elementSpacing), // 8-14dp
  ],
)
```

## Responsive Widgets

### ResponsivePaddingContainer

Wraps your content with adaptive padding:

```dart
ResponsivePaddingContainer(
  child: ListView(...),
)
```

### ResponsiveCard

Drop-in replacement for Card with responsive styling:

```dart
ResponsiveCard(
  onTap: () {},
  child: Text('Card content'),
)
```

### ResponsiveButton

Fully responsive button that adapts sizing:

```dart
ResponsiveButton(
  label: 'Submit',
  onPressed: () {},
  icon: Icons.check,
  isLoading: _isLoading,
)
```

### ResponsiveGrid

Adaptive grid that changes columns based on device:

```dart
ResponsiveGrid(
  columnsBuilder: (context) => context.gridColumns,
  children: items.map((item) => ItemCard(item)).toList(),
)
```

## Error Handling

### 1. Exception Hierarchy

All errors inherit from `AppException`:

```dart
- AppException
  ├── ServerException (Server errors, 5xx)
  ├── ClientException (Client errors, 4xx)
  ├── NetworkException (Network issues)
  ├── TimeoutException (Request timeouts)
  ├── AuthException (Authentication failures)
  ├── ValidationException (Validation errors)
  └── UnknownException (Unexpected errors)
```

### 2. Retry Logic

All exceptions have built-in retry logic:

```dart
if (error.isRetryable) {
  await Future.delayed(error.retryDelay);
  // retry operation
}
```

Retryable errors:
- `ServerException` - Retries up to 3 times
- `NetworkException` - Retries up to 3 times
- `TimeoutException` - Retries up to 3 times
- `AuthException` - Not retryable
- `ValidationException` - Not retryable

### 3. Repository Error Handling

Use `BaseRepository` for consistent error handling:

```dart
class MyRepository extends BaseRepository {
  final DioClient _dioClient;
  
  Future<ApiResponseWrapper<List<User>>> getUsers() async {
    return executeApi(
      () => _dioClient.get('/users'),
      fromJson: (json) => (json as List)
          .map((item) => User.fromJson(item))
          .toList(),
    );
  }
}
```

### 4. BLoC Error Handling

Use error states from `BaseState`:

```dart
class MyBloc extends Bloc<MyEvent, BaseState> {
  @override
  Stream<BaseState> mapEventToState(MyEvent event) async* {
    try {
      yield LoadingState();
      final result = await _repository.getData();
      yield SuccessState(result);
    } catch (error) {
      final exception = ErrorHandler.handle(error);
      yield ErrorState(exception);
    }
  }
}
```

### 5. UI Error Display

Use provided error widgets:

```dart
if (state is ErrorState) {
  ErrorSnackBar.show(context, state.error);
}

// Or show error widget with retry
ErrorWidget(
  error: error,
  onRetry: () => context.read<MyBloc>().add(RetryEvent()),
)
```

Success notification:

```dart
SuccessSnackBar.show(context, 'Operation successful!');
```

## API Integration

### 1. Making API Requests

```dart
final response = await dioClient.get(
  '/api/users',
  queryParameters: {'page': 1},
  token: authToken,
  retryOnError: true,
);
```

### 2. Retry Configuration

Automatic retry happens for:
- Status codes: 408, 429, 500, 502, 503, 504
- Connection timeouts
- Receive timeouts

No retry for:
- 401/403 (auth errors)
- 400/422 (client errors)

### 3. Custom Error Messages

Get user-friendly error messages:

```dart
String message = ErrorHandler.getUserFriendlyMessage(exception);
```

## Code Organization

### Feature Structure

```
lib/features/myfeature/
├── data/
│   ├── datasources/
│   │   └── my_data_source.dart
│   ├── models/
│   │   └── my_model.dart
│   └── repositories/
│       └── my_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── my_entity.dart
│   ├── repositories/
│   │   └── my_repository.dart
│   └── usecases/
│       └── my_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── my_bloc.dart
    │   ├── my_event.dart
    │   └── my_state.dart
    ├── pages/
    │   └── my_page.dart
    └── widgets/
        └── my_widgets.dart
```

### Clean Architecture Rules

1. **Domain is framework-independent** - No Flutter imports
2. **Data knows about Domain** - Data layer uses domain entities
3. **Presentation knows about Data** - UI uses repositories
4. **Never import upward** - Domain → Data → Presentation only

## Performance Optimization

### 1. Efficient Widget Updates

Use `ResponsiveExtension` to cache values:

```dart
final responsive = context.responsive;
final padding = responsive.horizontalPadding(); // Cache this
```

### 2. List Rendering

Use `ListView.builder` for lists:

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemTile(items[index]),
)
```

### 3. Image Optimization

Always provide size constraints:

```dart
Image.network(
  url,
  fit: BoxFit.cover,
  width: 100,
  height: 100,
)
```

### 4. State Management

Use BLoC for complex state:
- Minimal rebuilds
- Clear separation of concerns
- Easy to test

## Testing

### Unit Tests

Test repositories and use cases:

```dart
test('getUsers returns user list', () async {
  final result = await repository.getUsers();
  expect(result.isSuccess, true);
  expect(result.data, isA<List<User>>());
});
```

### Widget Tests

Test widgets with responsive values:

```dart
testWidgets('Button is responsive', (tester) async {
  await tester.binding.window.physicalSizeTestValue = Size(360, 800);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  
  await tester.pumpWidget(MyApp());
  expect(find.byType(ResponsiveButton), findsOneWidget);
});
```

## Common Patterns

### Loading with Previous Data

```dart
if (state is ListLoadingState && state.previousData != null) {
  // Show previous data while loading
  return ItemList(items: state.previousData!);
}
```

### Empty State

```dart
if (state is EmptyState) {
  return EmptyStateWidget(
    title: 'No items found',
    subtitle: 'Try adding something new',
    onRetry: () => context.read<MyBloc>().add(RefreshEvent()),
  );
}
```

### Pagination

```dart
if (state is PaginatedState) {
  return ListView.builder(
    itemCount: state.items.length + (state.hasMore ? 1 : 0),
    itemBuilder: (context, index) {
      if (index == state.items.length) {
        return LoadMoreButton(
          onPressed: () => loadMore(),
        );
      }
      return ItemTile(state.items[index]);
    },
  );
}
```

## Best Practices

1. **Always use context extensions** - `context.responsive`, `context.adaptiveFont`
2. **Wrap screens with ResponsivePaddingContainer** - Ensures consistent padding
3. **Use responsive widgets** - `ResponsiveCard`, `ResponsiveButton`, etc.
4. **Handle errors properly** - Always catch exceptions and show user feedback
5. **Test on multiple devices** - Use device preview or multiple emulators
6. **Cache expensive operations** - Don't recalculate responsive values repeatedly
7. **Follow the architecture** - Strict layer separation for maintainability
8. **Use meaningful names** - Self-documenting code instead of comments
9. **Keep BLoCs focused** - One responsibility per BLoC
10. **Clean up resources** - Close streams, cancel requests, dispose controllers

## Troubleshooting

### Responsive values not updating

Ensure you're calling getter methods, not accessing properties:
```dart
// Wrong
context.responsive.cardPadding  // This won't update on rotate

// Correct
context.responsive.cardPadding()  // This will update
```

### Overflow errors

Use `ResponsivePaddingContainer` and check device category:
```dart
ResponsivePaddingContainer(
  child: context.isSmallScreen 
    ? ListView(...) 
    : GridView(...),
)
```

### BLoC not updating UI

Check that:
1. Event is being added: `context.read<MyBloc>().add(MyEvent())`
2. State is being emitted: `yield SuccessState(data)`
3. BLoC is provided: `BlocProvider<MyBloc>(...)`
4. Listener is attached: `BlocListener<MyBloc, BaseState>(...)`

### Memory leaks

Always dispose:
- TextEditingControllers
- ScrollControllers
- StreamSubscriptions
- AudioPlayers, VideoControllers, etc.

---

**Last Updated**: April 2026
**Version**: 1.0
