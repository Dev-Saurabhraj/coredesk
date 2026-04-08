# CoreDesk Implementation Guide

This guide explains all the new systems implemented in the CoreDesk application for responsiveness, error handling, and scalability.

## Directory Structure

All new files have been created in the following structure:

```
lib/
├── core/
│   ├── bloc/
│   │   ├── base_events.dart          (New: Base event classes)
│   │   └── base_states.dart          (New: Base state classes)
│   ├── responsive/
│   │   ├── responsive_system.dart    (New: Responsive utilities)
│   │   └── responsive_extensions.dart (New: Context extensions)
│   ├── repositories/
│   │   └── base_repository.dart      (New: Base repository with error handling)
│   ├── exceptions/
│   │   └── exceptions.dart           (Updated: Enhanced exception types)
│   └── utils/
│       └── error_handler.dart        (New: Error handling utilities)
├── shared/
│   └── widgets/
│       ├── responsive_widgets.dart   (New: Reusable responsive widgets)
│       └── error_widgets.dart        (New: Error/loading UI widgets)
└── features/
    └── dashboard/
        └── presentation/
            └── pages/
                └── home_screen.dart  (Updated: Using new responsive system)
```

## New Features Implemented

### 1. Responsive System (core/responsive/)

**Files:**
- `responsive_system.dart` - Core responsive utilities
- `responsive_extensions.dart` - Context extensions for easy access

**Usage:**
```dart
context.responsive.horizontalPadding()      // Get responsive padding
context.gridColumns                          // Get responsive grid columns
context.adaptiveFont.bodyLarge()             // Get responsive font size
context.deviceCategory                       // Get device category
```

### 2. Enhanced Exception Handling (core/exceptions/)

**New Exception Types:**
- `TimeoutException` - Request timeouts
- `ClientException` - 4xx errors
- Plus existing: ServerException, NetworkException, AuthException, etc.

**Features:**
- Built-in retry logic (`isRetryable`, `retryDelay`)
- Stack trace capturing
- User-friendly messages via `ErrorHandler`

**Usage:**
```dart
if (error.isRetryable) {
  await Future.delayed(error.retryDelay);
  // retry
}
```

### 3. Error Handling Utilities (core/utils/)

**Components:**
- `ErrorHandler` - Converts exceptions to user-friendly messages
- `ApiResponseWrapper<T>` - Success/error wrapper for API responses
- `AsyncResult<T>` - Loading/success/error states

**Usage:**
```dart
final response = await executeApi(
  () => dioClient.get('/api/users'),
  fromJson: (json) => User.fromJson(json),
);

if (response.isSuccess) {
  final users = response.data;
}
```

### 4. Base Repository & BLoC (core/)

**BaseRepository:**
- Handles API calls with error handling
- Returns `ApiResponseWrapper` or `AsyncResult`
- Automatic exception conversion

**BaseStates & BaseEvents:**
- Standard states: InitialState, LoadingState, SuccessState, ErrorState, EmptyState
- Standard events: InitializeEvent, RefreshEvent, RetryEvent, ClearErrorEvent

**Usage:**
```dart
class MyRepository extends BaseRepository {
  Future<ApiResponseWrapper<Data>> getData() {
    return executeApi(
      () => apiClient.get('/endpoint'),
      fromJson: (json) => Data.fromJson(json),
    );
  }
}
```

### 5. Responsive Widgets (shared/widgets/)

**ResponsivePaddingContainer** - Auto-padding wrapper
**ResponsiveCard** - Responsive card component
**ResponsiveButton** - Fully responsive button
**ResponsiveGrid** - Adaptive grid layout
**ResponsiveTextInput** - Responsive text field
**ResponsiveSection** - Section with title and content
**ResponsiveListTile** - Responsive list item

**Usage:**
```dart
ResponsiveCard(
  child: Text('Content'),
)

ResponsiveButton(
  label: 'Submit',
  onPressed: () {},
)
```

### 6. Error & Loading UI Widgets (shared/widgets/)

**ErrorWidget** - Display errors with retry
**LoadingOverlay** - Show loading indicator
**EmptyStateWidget** - Display empty states
**ErrorSnackBar** - Show error snackbar
**SuccessSnackBar** - Show success snackbar

**Usage:**
```dart
if (state is ErrorState) {
  ErrorSnackBar.show(context, state.error);
}

ErrorWidget(
  error: error,
  onRetry: () => bloc.add(RetryEvent()),
)
```

## Enhanced DioClient

### Retry Logic
- Automatic retry for recoverable errors
- Exponential backoff with configurable delays
- Support for status codes: 408, 429, 500, 502, 503, 504
- Maximum 3 retries per request

### Error Handling
- Converts DioException to custom exceptions
- User-friendly error messages
- Proper timeout handling
- Network connectivity checks

### Usage:
```dart
final response = await dioClient.get(
  '/endpoint',
  retryOnError: true,  // Enable retry
  token: authToken,
);
```

## Integration Steps

### 1. Import the new systems in your BLoCs:

```dart
import 'package:coredesk/core/bloc/base_states.dart';
import 'package:coredesk/core/bloc/base_events.dart';
import 'package:coredesk/core/repositories/base_repository.dart';
import 'package:coredesk/core/responsive/responsive_extensions.dart';
```

### 2. Update Your BLoCs:

```dart
class MyBloc extends Bloc<MyEvent, BaseState> {
  final MyRepository _repository;
  
  MyBloc(this._repository) : super(InitialState()) {
    on<LoadDataEvent>(_onLoadData);
  }
  
  Future<void> _onLoadData(event, emit) async {
    try {
      emit(LoadingState());
      final result = await _repository.getData();
      
      if (result.isSuccess) {
        emit(SuccessState(result.data));
      } else {
        emit(ErrorState(result.error!));
      }
    } catch (error, stackTrace) {
      final exception = ErrorHandler.handle(error, stackTrace);
      emit(ErrorState(exception));
    }
  }
}
```

### 3. Update Your Repositories:

```dart
class MyRepository extends BaseRepository {
  final DioClient _client;
  
  MyRepository(this._client);
  
  Future<ApiResponseWrapper<List<Item>>> getItems() {
    return executeApi(
      () => _client.get('/items'),
      fromJson: (json) => (json as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}
```

### 4. Update Your UI Screens:

```dart
@override
Widget build(BuildContext context) {
  return ResponsivePaddingContainer(
    child: BlocBuilder<MyBloc, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (state is ErrorState) {
          return ErrorWidget(
            error: state.error,
            onRetry: () => context.read<MyBloc>().add(RetryEvent()),
          );
        }
        
        if (state is SuccessState) {
          return ListView(...)
        }
        
        return SizedBox.shrink();
      },
    ),
  );
}
```

## Migration Path

### For Existing Features:

1. **Update State Classes** - Inherit from `BaseState`
2. **Update Event Classes** - Inherit from `BaseEvent`
3. **Update Repositories** - Extend `BaseRepository`
4. **Update UI** - Use responsive extensions and widgets
5. **Update Error Handling** - Use `ErrorWidget` and `ErrorSnackBar`
6. **Test on Multiple Devices** - Verify responsiveness

### Gradual Migration:

- Start with one feature at a time
- Test thoroughly before moving to next
- Keep old system running in parallel as needed
- Update one screen per commit

## Performance Considerations

### Optimization Tips:

1. **Cache Responsive Values:**
```dart
final responsive = context.responsive;  // Cache reference
final padding = responsive.horizontalPadding();
```

2. **Use ListView.builder for Lists:**
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemTile(items[index]),
)
```

3. **Lazy Load Images:**
```dart
Image.network(
  url,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => Placeholder(),
)
```

4. **Use const for Static Widgets:**
```dart
class MyWidget extends StatelessWidget {
  const MyWidget();  // Make const whenever possible
}
```

## Testing

### Widget Tests:

```dart
testWidgets('Responsive button on small screen', (tester) async {
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  tester.binding.window.physicalSizeTestValue = Size(360, 800);
  
  await tester.pumpWidget(MyApp());
  
  expect(find.byType(ResponsiveButton), findsOneWidget);
  // Verify sizing for 360px width
});
```

### Unit Tests:

```dart
test('Error handler creates user-friendly message', () {
  final exception = TimeoutException(
    message: 'Connection timed out',
  );
  
  final message = ErrorHandler.getUserFriendlyMessage(exception);
  expect(message, isNotEmpty);
  expect(message, isA<String>());
});
```

## Common Issues & Solutions

### Issue: Responsive values not updating on orientation change
**Solution:** Use getter methods instead of cached values
```dart
// Wrong
final padding = context.responsive.horizontalPadding();  // Gets called once

// Correct
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.responsive.horizontalPadding(),  // Gets evaluated each build
  ),
)
```

### Issue: Overflow errors on small screens
**Solution:** Use ResponsivePaddingContainer and check device category
```dart
ResponsivePaddingContainer(
  child: context.isSmallScreen 
    ? ListView(...) 
    : GridView(...),
)
```

### Issue: Error states not showing retry button
**Solution:** Ensure ErrorWidget has onRetry callback
```dart
ErrorWidget(
  error: error,
  onRetry: () => context.read<MyBloc>().add(RetryEvent()),
  showRetry: true,  // Enable retry button
)
```

## Resources

- **Responsive System**: See `core/responsive/responsive_system.dart`
- **Error Handling**: See `core/utils/error_handler.dart`
- **Base Repository**: See `core/repositories/base_repository.dart`
- **Development Guidelines**: See `DEVELOPMENT.md`

## Support & Troubleshooting

For issues or questions:

1. Check `DEVELOPMENT.md` for detailed usage examples
2. Review example implementations in dashboard feature
3. Check error messages for specific guidance
4. Enable debug logging in DioClient for network issues

---

**Implementation Status**: ✅ Complete
**Last Updated**: April 2026
**Tested Devices**: 360px (xs), 480px (sm), 720px (md), 1200px (lg)
