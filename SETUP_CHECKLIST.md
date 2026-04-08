# CoreDesk Project Setup Checklist

Complete this checklist to ensure all systems are properly integrated.

## 1. Core Responsive System ✅

### Verify Files Exist:
- [x] `lib/core/responsive/responsive_system.dart`
- [x] `lib/core/responsive/responsive_extensions.dart`

### Test Responsive System:
```bash
# Run this to verify responsive values work
flutter run -d web
# Test on different screen sizes using DevTools
```

### Verification Points:
- [ ] `context.responsive` works in any widget
- [ ] `context.adaptiveFont` returns correct sizes
- [ ] `context.deviceCategory` updates on orientation change
- [ ] Font sizes scale correctly across all categories

---

## 2. Exception Handling ✅

### Verify Files:
- [x] `lib/core/exceptions/exceptions.dart` (enhanced)
- [x] `lib/core/utils/error_handler.dart`

### Test Error Handling:
```dart
try {
  throw TimeoutException(message: 'Test timeout');
} catch (error) {
  final handled = ErrorHandler.handle(error);
  print(handled.message);  // Should be user-friendly
  print(handled.isRetryable);  // Should be true
}
```

### Verification Points:
- [ ] All exception types are available
- [ ] `ErrorHandler.handle()` converts errors correctly
- [ ] `ErrorHandler.getUserFriendlyMessage()` returns proper messages
- [ ] Retry logic (`isRetryable`, `retryDelay`) works

---

## 3. Base Repository & States ✅

### Verify Files:
- [x] `lib/core/repositories/base_repository.dart`
- [x] `lib/core/bloc/base_states.dart`
- [x] `lib/core/bloc/base_events.dart`

### Update One Feature:
- [ ] Create new repository extending `BaseRepository`
- [ ] Update BLoC to use `BaseState` classes
- [ ] Add `BaseEvent` classes
- [ ] Test data flow with error scenarios

### Verification Points:
- [ ] Repositories use `executeApi()` method
- [ ] BLoC emits proper state types
- [ ] Error states show error widget
- [ ] Loading states show loading indicator

---

## 4. Responsive Widgets ✅

### Verify Files:
- [x] `lib/shared/widgets/responsive_widgets.dart`
- [x] `lib/shared/widgets/error_widgets.dart`

### Use in Screens:
- [ ] Replace Card with `ResponsiveCard`
- [ ] Replace ElevatedButton with `ResponsiveButton`
- [ ] Replace Padding with `ResponsivePaddingContainer`
- [ ] Replace error handling with `ErrorWidget`/`ErrorSnackBar`

### Verification Points:
- [ ] Responsive widgets adapt to screen size
- [ ] Error widgets show retry option
- [ ] Loading overlay blocks interaction
- [ ] Empty states display correctly

---

## 5. Enhanced DioClient ✅

### Verify Features:
- [x] Retry logic implemented
- [x] Error conversion in place
- [x] Timeout handling active

### Test Network Errors:
```bash
# Test with network off
# Verify auto-retry happens
# Check error messages are user-friendly
```

### Verify Points:
- [ ] API calls retry automatically
- [ ] Timeout doesn't crash app
- [ ] Network errors handled gracefully
- [ ] Auth errors trigger logout flow

---

## 6. Updated Home Screen ✅

### File:
- [x] `lib/features/dashboard/presentation/pages/home_screen.dart`

### Verification Points:
- [ ] Uses `context.responsive` for spacing
- [ ] Uses `context.adaptiveFont` for text
- [ ] Uses responsive widgets
- [ ] Shows error widget on failure
- [ ] Loads correctly on all screen sizes

---

## 7. Documentation ✅

### Files Created:
- [x] `README.md` (comprehensive project overview)
- [x] `DEVELOPMENT.md` (developer guidelines)
- [x] `IMPLEMENTATION.md` (integration guide)

### Documentation Quality:
- [ ] All code examples tested
- [ ] Architecture diagrams clear
- [ ] Best practices documented
- [ ] Common issues addressed

---

## 8. Feature Migration Checklist

Choose one feature to migrate first. Complete all steps:

### Selected Feature: `_________________`

- [ ] **Step 1: Update States**
  - [ ] Inherit from `BaseState`
  - [ ] Remove old error/loading states
  - [ ] Add states: Initial, Loading, Success, Error, Empty

- [ ] **Step 2: Update Events**
  - [ ] Inherit from `BaseEvent`
  - [ ] Add: Initialize, Refresh, Retry, Clear Error events
  - [ ] Add feature-specific events

- [ ] **Step 3: Update Repository**
  - [ ] Extend `BaseRepository`
  - [ ] Use `executeApi()` method
  - [ ] Return `ApiResponseWrapper<T>`

- [ ] **Step 4: Update BLoC**
  - [ ] Handle all base events
  - [ ] Emit proper states
  - [ ] Use error handler

- [ ] **Step 5: Update Screens**
  - [ ] Use responsive extensions
  - [ ] Show error widget
  - [ ] Show loading state
  - [ ] Show empty state
  - [ ] Use responsive widgets

- [ ] **Step 6: Test on Devices**
  - [ ] Extra Small (< 360px)
  - [ ] Small (360-480px)
  - [ ] Medium (480-720px)
  - [ ] Large (720px+)

- [ ] **Step 7: Test Error Scenarios**
  - [ ] Network offline
  - [ ] Timeout
  - [ ] 401 auth error
  - [ ] 500 server error
  - [ ] Empty data

---

## 9. Integration Testing

Run all tests to ensure everything works:

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Generate coverage report
flutter test --coverage
```

### Tests to Create:
- [ ] Responsive system adapts values correctly
- [ ] Error handler converts errors properly
- [ ] Repository executeApi works
- [ ] BLoC emits correct states
- [ ] Widgets render on all screen sizes
- [ ] Error widgets show/hide correctly

---

## 10. Performance Verification

### Check Performance:
```bash
# Open DevTools
flutter pub global activate devtools
devtools

# Check in browser:
# - Memory usage stable
# - No memory leaks
# - Frame rate 60 fps
# - No jank on scrolling
```

### Optimization Checklist:
- [ ] Use `const` constructors
- [ ] Cache expensive computations
- [ ] Use `ListView.builder` for lists
- [ ] Lazy load images
- [ ] Profile app in release mode

---

## 11. Pre-Release Verification

Before deploying:

### Code Quality:
- [ ] No console errors or warnings
- [ ] No unused imports
- [ ] No magic numbers
- [ ] All code is self-documenting
- [ ] No TODOs left

### Functionality:
- [ ] All screens load correctly
- [ ] Navigation works smoothly
- [ ] Error handling works properly
- [ ] No crashes observed
- [ ] Performance is acceptable

### User Experience:
- [ ] Text is readable on all devices
- [ ] Buttons are touch-friendly (44x44dp+)
- [ ] No overlapping UI elements
- [ ] Consistent spacing throughout
- [ ] Proper error messages shown

### Security:
- [ ] No credentials in code
- [ ] API keys secured
- [ ] Token refresh working
- [ ] Logout cleans state
- [ ] No sensitive data in logs

---

## 12. Deployment Checklist

### Android:
- [ ] Build signed APK
- [ ] Test on multiple devices
- [ ] Check Play Store requirements
- [ ] Upload to Play Store beta
- [ ] Monitor crash reports

### iOS:
- [ ] Build signed IPA
- [ ] Test on multiple devices
- [ ] Check App Store requirements
- [ ] Upload to TestFlight
- [ ] Monitor crash reports

---

## Common Issues During Integration

### Issue: Imports not resolving
**Solution:** Run `flutter pub get` and restart IDE

### Issue: Responsive values not changing
**Solution:** Use getter methods, not cached values

### Issue: StateError: Bad state: No element
**Solution:** Check list operations for empty lists first

### Issue: Memory leak warning
**Solution:** Dispose all controllers and subscriptions

### Issue: UI looks off on some screens
**Solution:** Check all paddings use responsive values

---

## Next Steps

1. Create a branch: `git checkout -b feat/integrate-responsive`
2. Run setup checklist for one feature
3. Test thoroughly on multiple devices
4. Create PR for review
5. Iterate based on feedback
6. Merge when approved
7. Deploy to production

---

## Support Resources

- **README.md** - Project overview
- **DEVELOPMENT.md** - Developer guidelines  
- **IMPLEMENTATION.md** - Integration guide
- **Code Examples** - See `home_screen.dart`

---

**Completion Target**: All items checked within 2 weeks
**Last Updated**: April 2026
**Status**: Ready for Implementation ✅
