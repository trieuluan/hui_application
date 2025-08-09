# Error Handling System

Hệ thống xử lý lỗi tùy chỉnh cho ứng dụng HUI, thay thế màn hình đỏ mặc định của Flutter.

## 🎯 **Features**

### ✅ **Custom Error Widget**
- Thay thế màn hình đỏ của Flutter
- Giao diện thân thiện với người dùng
- Hiển thị chi tiết lỗi cho developer
- Nút "Thử lại" và "Khởi động lại"
- Sao chép thông tin lỗi

### ✅ **Error Handler Service**
- Xử lý lỗi toàn cục
- Phân loại lỗi (Network, Validation, Auth)
- Hiển thị SnackBar, Dialog, BottomSheet
- Logging và reporting

### ✅ **Error Boundary Widget**
- Bắt lỗi trong widget tree
- Không làm crash toàn bộ app
- Retry mechanism

## 🚀 **Usage**

### **1. Global Error Handling (Đã setup trong main.dart)**

```dart
// main.dart
void main() async {
  // ... other initialization
  
  // Setup error handling
  ErrorHandlerService.setupErrorHandling();
  
  runApp(const ProviderScope(child: PlatformApp()));
}
```

### **2. Handle Specific Errors**

```dart
// Network error
ErrorHandlerService.handleNetworkError(
  context, 
  'Không thể kết nối đến server'
);

// Validation error
ErrorHandlerService.handleValidationError(
  context, 
  'Dữ liệu không hợp lệ'
);

// Auth error
ErrorHandlerService.handleAuthError(
  context, 
  'Phiên đăng nhập đã hết hạn'
);
```

### **3. Show Custom Error Dialogs**

```dart
// Simple error dialog
ErrorHandlerService.showErrorDialog(
  context,
  title: 'Lỗi',
  message: 'Đã xảy ra lỗi không mong muốn',
);

// Error dialog with action
ErrorHandlerService.showErrorDialog(
  context,
  title: 'Lỗi kết nối',
  message: 'Vui lòng kiểm tra kết nối internet',
  actionLabel: 'Thử lại',
  onAction: () => retryConnection(),
);
```

### **4. Show Error Bottom Sheet**

```dart
ErrorHandlerService.showErrorBottomSheet(
  context,
  title: 'Lỗi tải dữ liệu',
  message: 'Không thể tải danh sách người dùng',
  actions: [
    ElevatedButton(
      onPressed: () => retryLoadUsers(),
      child: const Text('Thử lại'),
    ),
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('Đóng'),
    ),
  ],
);
```

### **5. Wrap Widgets with Error Boundary**

```dart
// Wrap entire screen
ErrorBoundary(
  onError: () => logError('Screen error'),
  child: MyScreen(),
);

// Wrap specific section
ErrorBoundarySection(
  sectionName: 'User List',
  onRetry: () => loadUsers(),
  child: UserListWidget(),
);
```

### **6. Custom Error Widget**

```dart
// Direct usage
CustomErrorWidget(
  errorDetails: errorDetails,
  onRetry: () => retry(),
  showDetails: true, // Show error details
);

// Using builder
CustomErrorWidgetBuilder.buildErrorWidget(
  errorDetails,
  onRetry: () => retry(),
  showDetails: false,
);
```

## 🎨 **Customization**

### **Custom Error Widget Styling**

```dart
// Modify colors, text, layout in custom_error_widget.dart
class CustomErrorWidget extends StatelessWidget {
  // Customize appearance here
}
```

### **Custom Error Messages**

```dart
// Add new error types in error_handler_service.dart
static void handleCustomError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Custom Error: $message'),
      backgroundColor: Colors.purple,
    ),
  );
}
```

### **Custom Error Boundary**

```dart
// Create custom error boundary
class CustomErrorBoundary extends ErrorBoundary {
  @override
  Widget build(BuildContext context) {
    // Custom error UI
  }
}
```

## 🔧 **Integration with Crash Reporting**

### **Firebase Crashlytics**

```dart
// In error_handler_service.dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

static void handleError(FlutterErrorDetails details) {
  // Log to console
  FlutterError.dumpErrorToConsole(details);
  
  // Send to Crashlytics
  FirebaseCrashlytics.instance.recordFlutterError(details);
}
```

### **Sentry**

```dart
// In error_handler_service.dart
import 'package:sentry_flutter/sentry_flutter.dart';

static void handleError(FlutterErrorDetails details) {
  // Log to console
  FlutterError.dumpErrorToConsole(details);
  
  // Send to Sentry
  Sentry.captureException(details.exception, stackTrace: details.stack);
}
```

## 📱 **Testing**

### **Force Error for Testing**

```dart
// Add this button to test error handling
ElevatedButton(
  onPressed: () {
    throw Exception('Test error for error handling');
  },
  child: const Text('Test Error'),
),
```

### **Test Error Boundary**

```dart
// Widget that throws error
class ErrorTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw Exception('Test error boundary');
  }
}

// Wrap with error boundary
ErrorBoundary(
  child: ErrorTestWidget(),
),
```

## 🎯 **Best Practices**

### **1. Use Appropriate Error Types**
- `handleNetworkError`: Lỗi kết nối
- `handleValidationError`: Lỗi dữ liệu
- `handleAuthError`: Lỗi xác thực

### **2. Provide Retry Mechanisms**
- Luôn có nút "Thử lại" khi có thể
- Implement retry logic hợp lý

### **3. User-Friendly Messages**
- Không hiển thị technical details cho user
- Sử dụng ngôn ngữ dễ hiểu
- Cung cấp hướng dẫn giải quyết

### **4. Log Errors Properly**
- Log đầy đủ thông tin lỗi
- Gửi lên crash reporting service
- Track error patterns

### **5. Graceful Degradation**
- App không crash hoàn toàn
- Hiển thị fallback UI
- Cho phép user tiếp tục sử dụng

## 🚨 **Error Types**

| Error Type | Usage | Example |
|------------|-------|---------|
| Network | API calls, internet | `handleNetworkError(context, 'Connection failed')` |
| Validation | Form validation | `handleValidationError(context, 'Invalid email')` |
| Auth | Login, permissions | `handleAuthError(context, 'Session expired')` |
| General | Unknown errors | `showErrorDialog(context, title: 'Error', message: '...')` |

## 📞 **Support**

Nếu gặp vấn đề với error handling system, vui lòng:

1. Kiểm tra console logs
2. Xem chi tiết lỗi trong CustomErrorWidget
3. Contact development team với error details 