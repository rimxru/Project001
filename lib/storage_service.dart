import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'anime_data.dart';

class StorageService {
  static const String _commentsKey = 'anime_comments';
  static const String _favoritesKey = 'user_favorites';

  // Helper method to get all comments as a map
  static Map<String, dynamic> _getAllCommentsMap(SharedPreferences prefs) {
    final stored = prefs.getString(_commentsKey);
    if (stored == null) return {};

    try {
      return jsonDecode(stored) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  // Helper method to get all favorites as a map
  static Map<String, dynamic> _getAllFavoritesMap(SharedPreferences prefs) {
    final stored = prefs.getString(_favoritesKey);
    if (stored == null) return {};

    try {
      return jsonDecode(stored) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  // Save comments for a specific anime
  static Future<void> saveComments(int animeId, List<Comment> comments) async {
    final prefs = await SharedPreferences.getInstance();
    final allComments = _getAllCommentsMap(prefs);

    allComments[animeId.toString()] = comments
        .map((comment) => comment.toJson())
        .toList();

    await prefs.setString(_commentsKey, jsonEncode(allComments));
  }

  // Load comments for a specific anime
  static Future<List<Comment>> loadComments(int animeId) async {
    final prefs = await SharedPreferences.getInstance();
    final allComments = _getAllCommentsMap(prefs);

    final animeComments = allComments[animeId.toString()] as List<dynamic>?;
    if (animeComments == null) return [];

    return animeComments
        .map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
        .toList();
  }

  // Save favorites for a user
  static Future<void> saveFavorites(
    String username,
    List<int> favorites,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final allFavorites = _getAllFavoritesMap(prefs);

    allFavorites[username] = favorites;

    await prefs.setString(_favoritesKey, jsonEncode(allFavorites));
  }

  // Load favorites for a user
  static Future<List<int>> loadFavorites(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final allFavorites = _getAllFavoritesMap(prefs);

    final userFavorites = allFavorites[username] as List<dynamic>?;
    if (userFavorites == null) return [];

    return userFavorites.cast<int>();
  }

  // Clear all stored data (for logout)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_commentsKey);
    await prefs.remove(_favoritesKey);
  }
}
