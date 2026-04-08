# Quick Reference Guide - CoreDesk

Ultra-fast reference for common tasks in CoreDesk development.

## Responsive Spacing

```dart
// Horizontal padding
context.responsive.horizontalPadding()      // 12-18dp

// Vertical padding  
context.responsive.verticalPadding()        // 8-14dp

// Top padding (header)
context.responsive.headerPadding()          // 24-36dp

// Spacing between sections
context.responsive.sectionSpacing()         // 16-24dp

// Spacing between elements
context.responsive.elementSpacing()         // 8-14dp

// Card padding
context.responsive.cardPadding()            // 14-20dp
```

## Responsive Font Sizes

```dart
// Display fonts (hero sections)
- displayLarge()     // 28-42dp
- displayMedium()    // 24-36dp
- displaySmall()     // 20-28dp

// Headlines (page titles)
- headlineLarge()    // 18-26dp
- headlineMedium()   // 16-24dp
- headlineSmall()    // 14-18dp

// Titles (card titles)
- titleLarge()       // 16-20dp
- titleMedium()      // 14-18dp
- titleSmall()       // 12-16dp

// Body text
- bodyLarge()        // 14-18dp
- bodyMedium()       // 12-16dp
- bodySmall()        // 10-14dp

// Labels (buttons, badges)
- labelLarge()       // 12-16dp
- labelMedium()      // 11-14dp
- labelSmall()       // 10-12dp
```

## Border Radius

```dart
// Large (main containers)
context.responsive.borderRadiusLarge()      // 18-24dp

// Medium (cards, dialogs)
context.responsive.borderRadiusMedium()     // 12-16dp

// Small (buttons, chips)
context.responsive.borderRadiusSmall()      // 8-10dp
```

## Icon Sizes

```dart
// Extra Small
context.responsive.iconSizeXSmall()         // 16-22dp

// Small
context.responsive.iconSizeSmall()          // 20-28dp

// Medium
context.responsive.iconSizeMedium()         // 28-36dp

// Large
context.responsive.iconSizeLarge()          // 40-56dp
```

## Device Categories

```dart
context.deviceCategory == DeviceCategory.extraSmall  // < 360px
context.deviceCategory == DeviceCategory.small       // 360-480px
context.deviceCategory == DeviceCategory.medium      // 480-720px
context.deviceCategory == DeviceCategory.large       // 720px+
```

## Quick Device Checks

```dart
context.isSmallScreen      // < 480px
context.isMediumScreen     // 480-720px
context.isLargeScreen      // >= 720px
context.isPortrait         // Portrait mode
context.isLandscape        // Landscape mode
```

## Common Padding Combinations

```dart
// Screen padding (horizontal + vertical)
Padding(
  padding: context.screenPadding,
  child: content,
)

// Card margin
Padding(
  padding: context.cardMargin,
  child: content,
)

// Horizontal only
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.horizontalPadding,
  ),
  child: content,
)

// Vertical only
Padding(
  padding: EdgeInsets.symmetric(
    vertical: context.verticalPadding,
  ),
  child: content,
)
```

## Frequently Used Widgets

```dart
// Responsive container with padding
ResponsivePaddingContainer(child: widget)

// Responsive card
ResponsiveCard(child: widget)

// Responsive button
ResponsiveButton(
  label: 'Submit',
  onPressed: () {},
)

// Responsive grid
ResponsiveGrid(
  columnsBuilder: (context) => context.gridColumns,
  children: items,
)

// Error display
ErrorWidget(
  error: error,
  onRetry: () {},
)

// Loading overlay
LoadingOverlay(
  isLoading: true,
  child: content,
)

// Empty state
EmptyStateWidget(
  title: 'No items',
  subtitle: 'Add something new',
)
```

## Error Handling

### Show Error Snackbar
```dart
ErrorSnackBar.show(context, exception);

// With retry
ErrorSnackBar.showWithRetry(
  context, 
  exception,
  () => bloc.add(RetryEvent()),
);
```

### Show Success Message
```dart
SuccessSnackBar.show(context, 'Done!');
```

### Get User-Friendly Message
```dart
String message = ErrorHandler.getUserFriendlyMessage(exception);
```

## BLoC Pattern

### Standard State Handling
```dart
BlocBuilder<MyBloc, BaseState>(
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
    
    if (state is SuccessState<MyData>) {
      return MyDataWidget(data: state.data);
    }
    
    return SizedBox.shrink();
  },
)
```

### Standard Repository Pattern
```dart
class MyRepository extends BaseRepository {
  final DioClient _client;
  
  Future<ApiResponseWrapper<MyData>> getData() {
    return executeApi(
      () => _client.get('/api/endpoint'),
      fromJson: (json) => MyData.fromJson(json),
    );
  }
}
```

## Text Widget Shortcuts

```dart
// Large title
Text(
  'Title',
  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
    fontSize: context.adaptiveFont.headlineLarge(),
  ),
)

// Body text
Text(
  'Body',
  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    fontSize: context.adaptiveFont.bodyMedium(),
  ),
)

// Small text
Text(
  'Small',
  style: Theme.of(context).textTheme.labelSmall?.copyWith(
    fontSize: context.adaptiveFont.labelSmall(),
  ),
)
```

## Grid Layout

```dart
// Auto columns based on device
int columns = context.gridColumns;

// Row-based
int columns = context.responsive.gridColumnsPortrait;

// Column-based
int columns = context.responsive.gridColumnsLandscape;

// Grid spacing
double spacing = context.responsive.gridSpacing;
```

## Container with Border Radius

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      context.borderRadiusMedium,
    ),
  ),
)
```

## Common Color References

```dart
AppColors.primary              // Primary brand color
AppColors.secondary            // Secondary color
AppColors.accent               // Accent color
AppColors.error                // Error state
AppColors.success              // Success state
AppColors.warning              // Warning state
AppColors.info                 // Info state
AppColors.onSurface            // Text on light background
AppColors.onSurfaceVariant     // Secondary text
AppColors.outlineVariant       // Borders
```

## API Calls with Retry

```dart
// Get with retry
await dioClient.get(
  '/endpoint',
  retryOnError: true,
  token: authToken,
)

// Post with retry
await dioClient.post(
  '/endpoint',
  data: payload,
  retryOnError: true,
)

// Disable retry for specific calls
await dioClient.get(
  '/endpoint',
  retryOnError: false,
)
```

## Checking Async State

```dart
AsyncResult<T> result = ...;

if (result.isSuccess) {
  final data = result.data;
}

if (result.isError) {
  final error = result.error;
}

if (result.isLoading) {
  // Show loading
}
```

## Available Base States

```dart
InitialState()              // Initial state
LoadingState()              // Loading data
SuccessState(data)          // Success with data
ErrorState(error)           // Error occurred
EmptyState(message)         // No data available
ListLoadingState(data)      // Loading with previous data
PaginatedState(...)         // Paginated list
```

## Media Query Shortcuts

```dart
// Don't use directly, use these instead:
context.screenWidth
context.screenHeight
context.responsive.scale(size)
context.containerWidth(baseWidth)
context.containerHeight(baseHeight)
```

## Common Patterns

### Loading with Previous Data
```dart
if (state is ListLoadingState && state.previousData != null) {
  return ListView(
    children: state.previousData!.map(...).toList(),
  );
}
```

### Pagination
```dart
if (state is PaginatedState) {
  itemCount = state.items.length + (state.hasMore ? 1 : 0);
}
```

### Field Validation Errors
```dart
ValidationException(
  message: 'Validation failed',
  fieldErrors: {
    'email': 'Invalid email format',
    'password': 'Too short',
  },
)
```

## Debug Tips

### Check Device Category
```dart
print(context.deviceCategory);  // Shows current category
```

### Check Responsive Values
```dart
print(context.responsive.horizontalPadding());
print(context.adaptiveFont.bodyLarge());
```

### Network Debugging
Enable logging in DioClient to see all requests/responses

### Memory Profiling
Use DevTools Memory tab to check for leaks

---

**Pro Tips:**
- Always use `context.responsive` for dimension-dependent values
- Cache responsive reference for multiple uses: `final r = context.responsive;`
- Test on all 4 device categories during development
- Use `const` constructors to reduce rebuilds
- Add error handling to all network calls
- Show meaningful error messages to users

**Last Updated**: April 2026
