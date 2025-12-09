// Simple in-app authentication service
import 'storage_service.dart';

class User {
  final String username;
  final List<int> favorites; // List of anime IDs

  User({required this.username, List<int>? favorites})
    : favorites = favorites ?? [];

  // Add anime to favorites
  void addFavorite(int animeId) {
    if (!favorites.contains(animeId)) {
      favorites.add(animeId);
    }
  }

  // Remove anime from favorites
  void removeFavorite(int animeId) {
    favorites.remove(animeId);
  }

  // Check if anime is in favorites
  bool isFavorite(int animeId) {
    return favorites.contains(animeId);
  }
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  static User? _currentUser;

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

  // Login user (no password required)
  static Future<String?> login({required String username}) async {
    if (username.isEmpty) {
      return 'Please enter a username';
    }

    if (username.length < 2) {
      return 'Username must be at least 2 characters';
    }

    // Create/login user with just username
    _currentUser = User(username: username);

    // Load persisted favorites from storage
    final savedFavorites = await StorageService.loadFavorites(username);
    if (savedFavorites.isNotEmpty) {
      _currentUser!.favorites.addAll(savedFavorites);
    }

    return null; // Success
  }

  // Logout user
  static Future<void> logout() async {
    _currentUser = null;
    // Clear all stored data on logout
    await StorageService.clearAll();
  }
}
