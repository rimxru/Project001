// Simple in-app authentication service
class User {
  final String email;
  final String password;
  final String username;

  User({required this.email, required this.password, required this.username});
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  static User? _currentUser;
  static final List<User> registeredUsers = [];

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Check if user is logged in
  static bool isLoggedIn() {
    return _currentUser != null;
  }

  // Get current user
  static User? getCurrentUser() {
    return _currentUser;
  }

  // Sign up new user
  static Future<String?> signup({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    // Validate inputs
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      return 'Please fill in all fields';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Check if email already exists
    if (registeredUsers.any((user) => user.email == email)) {
      return 'Email already registered';
    }

    // Check if username already exists
    if (registeredUsers.any((user) => user.username == username)) {
      return 'Username already taken';
    }

    // Create new user
    final newUser = User(email: email, password: password, username: username);

    registeredUsers.add(newUser);
    return null; // Success
  }

  // Login user
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill in all fields';
    }

    // Find user with matching email and password
    try {
      final user = registeredUsers.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      _currentUser = user;
      return null; // Success
    } catch (e) {
      return 'Invalid email or password';
    }
  }

  // Logout user
  static void logout() {
    _currentUser = null;
  }
}
