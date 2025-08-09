# Password Feedback System

Hệ thống hiển thị warning và suggestion cho client khi validate password từ BE.

## 🎯 **Mục đích:**

Hiển thị real-time feedback từ BE về:
- **Warning**: Cảnh báo về mật khẩu yếu
- **Suggestions**: Gợi ý cải thiện mật khẩu
- **Score**: Độ mạnh mật khẩu (0-4)
- **Loading State**: Trạng thái đang kiểm tra

## 🏗️ **Cấu trúc:**

### **1. PasswordStrengthProvider**
```dart
// Quản lý state của password strength với Riverpod
final passwordStrengthProvider = NotifierProvider<PasswordStrengthNotifier, PasswordStrengthState>

// State bao gồm:
class PasswordStrengthState {
  final PasswordStrengthResponse? response;  // Response từ BE
  final bool isLoading;                      // Đang loading
  final String? error;                       // Lỗi nếu có
}

// Notifier với Riverpod
class PasswordStrengthNotifier extends Notifier<PasswordStrengthState> {
  @override
  PasswordStrengthState build() {
    return const PasswordStrengthState();
  }
  
  Future<void> checkPasswordStrength(String password) async {
    // Implementation
  }
}
```

### **2. PasswordFeedbackWidget**
```dart
// Widget hiển thị feedback
PasswordFeedbackWidget(
  passwordControl: form.control('password'),
  strengthResponse: strengthState.response,
  isLoading: strengthState.isLoading,
  showSuggestions: true,
)
```

### **3. PasswordStrengthValidator**
```dart
// Validator với debounce và cache
PasswordStrengthValidator.validatePassword(password, ref)
PasswordStrengthValidator.updatePasswordStrengthProvider(password, ref)
```

## 📱 **Cách sử dụng:**

### **1. Trong RegisterStep:**
```dart
// Import
import 'package:hui_application/widgets/password_feedback_widget.dart';
import 'package:hui_application/features/auth/providers/password_strength_provider.dart';

// Trong build method
Widget _buildPasswordFeedback() {
  final strengthState = ref.watch(passwordStrengthProvider);
  final passwordControl = form!.control('password') as FormControl<String>;

  return PasswordFeedbackWidget(
    passwordControl: passwordControl,
    strengthResponse: strengthState.response,
    showSuggestions: true,
    isLoading: strengthState.isLoading,
  );
}

// Trong password field onChanged
onChanged: (control) {
  final password = control.value as String;
  ref.read(authFlowNotifierProvider.notifier).setPassword(password);
  
  // Update provider for real-time feedback
  PasswordStrengthValidator.updatePasswordStrengthProvider(password, ref);
},
```

### **2. Response từ BE:**
```json
{
  "score": 2,
  "isStrong": false,
  "feedback": {
    "warning": "Mật khẩu này dễ đoán",
    "suggestions": [
      "Thêm ký tự đặc biệt",
      "Sử dụng từ dài hơn",
      "Tránh thông tin cá nhân"
    ]
  },
  "additionalValidation": {
    "errors": []
  }
}
```

## 🎨 **UI Components:**

### **1. Warning Section:**
- Icon: ⚠️ Warning amber
- Text: Warning message từ BE
- Color: Error/Orange/Yellow tùy score

### **2. Suggestions Section:**
- Icon: 💡 Lightbulb outline
- Text: List suggestions từ BE
- Color: Primary theme color

### **3. Score Indicator:**
- Progress bar: 0-4 score
- Text: "Rất yếu" / "Yếu" / "Trung bình" / "Mạnh"
- Color: Tùy theo score

### **4. Loading State:**
- Spinner: Circular progress
- Text: "Đang kiểm tra độ mạnh mật khẩu..."
- Color: Primary theme color

## 🔧 **Features:**

### **✅ Real-time Feedback:**
- Debounce 300ms cho provider update
- Debounce 500ms cho validation
- Cache kết quả để tránh duplicate API calls

### **✅ Smart Display:**
- Chỉ hiển thị khi password không empty
- Ẩn khi password strong
- Loading state khi đang check
- Error handling

### **✅ Theme Integration:**
- Sử dụng theme colors
- Responsive design
- Consistent với app design

### **✅ Performance:**
- Debounced API calls
- Cached results
- Minimal re-renders

## 🚀 **Benefits:**

1. **User Experience**: Real-time feedback giúp user tạo mật khẩu mạnh
2. **Security**: Guidance từ BE về password strength
3. **Consistency**: Unified feedback system
4. **Performance**: Optimized với debounce và cache
5. **Maintainability**: Clean architecture với Riverpod providers
6. **Modern State Management**: Sử dụng Riverpod NotifierProvider hiện đại

## 🔄 **Flow:**

1. User nhập password
2. `onChanged` trigger `updatePasswordStrengthProvider`
3. Provider set loading state
4. Debounced API call đến BE
5. Response update provider state
6. `PasswordFeedbackWidget` rebuild với data mới
7. UI hiển thị warning/suggestions/score

## 📝 **Notes:**

- Widget chỉ hiển thị khi password không empty và không strong
- Loading state hiển thị khi đang check
- Error state được handle gracefully
- Cache giúp tránh duplicate API calls
- Debounce giúp performance tốt hơn 