import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final storage = GetStorage();

  Rx<User?> user = Rx<User?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = FirebaseAuth.instance.currentUser;
    _authService.authStateChanges.listen((User? newUser) {
      user.value = newUser;
      // Clear error message when user state changes
      if (newUser == null) {
        errorMessage.value = '';
      }
    });
  }

  // Clear error messages
  void clearError() {
    errorMessage.value = '';
  }

  String _handleAuthError(dynamic error) {
    String errorMessage = 'An unexpected error occurred. Please try again.';
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        case 'user-not-found':
          errorMessage = 'No account found with this email. Please check your email or register.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email. Please login instead.';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your internet connection and try again.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many unsuccessful attempts. Please try again later.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid login credentials. Please check your email and password.';
          break;
        case 'account-exists-with-different-credential':
          errorMessage = 'An account already exists with a different sign-in method.';
          break;
        default:
          if (error.message != null && error.message.toString().contains('credential')) {
            errorMessage = 'Invalid login credentials. Please check your email and password.';
          } else {
            errorMessage = 'Authentication failed. Please try again or contact support.';
          }
          break;
      }
    }
    return errorMessage;
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      if (email.isEmpty) {
        errorMessage.value = 'Please enter your email address.';
        isLoading.value = false;
        return;
      }
      if (password.isEmpty) {
        errorMessage.value = 'Please enter your password.';
        isLoading.value = false;
        return;
      }
      final loggedInUser = await _authService.login(email, password);
      if (loggedInUser != null) {
        user.value = loggedInUser;
        userName.value = storage.read('userName') ?? '';
        Get.offAllNamed('/home');
      }
    } catch (e) {
      errorMessage.value = _handleAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      if (name.isEmpty) {
        errorMessage.value = 'Please enter your name.';
        isLoading.value = false;
        return;
      }
      if (email.isEmpty) {
        errorMessage.value = 'Please enter your email address.';
        isLoading.value = false;
        return;
      }
      if (password.isEmpty) {
        errorMessage.value = 'Please enter a password.';
        isLoading.value = false;
        return;
      }
      final registeredUser = await _authService.register(name, email, password);
      if (registeredUser != null) {
        user.value = registeredUser;
        userName.value = name;
        storage.write('userName', name);
        Get.offAllNamed('/home');
      }
    } catch (e) {
      errorMessage.value = _handleAuthError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await _authService.logout();
      storage.erase();
      userName.value = '';
      user.value = null; // Explicitly set user to null
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = 'Failed to log out. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
} 