import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'constants.dart';
import 'anime_data.dart';
import 'storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: AuthService.isLoggedIn()
          ? const AnimeReviewScreen()
          : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/reviews': (context) => const AnimeReviewScreen(),
      },
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await AuthService.login(
        username: usernameController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (result == null) {
        Navigator.of(context).pushReplacementNamed('/reviews');
      } else {
        setState(() {
          errorMessage = result;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.loginGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingLarge),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ANIME REVIEWS',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 2) {
                        return 'Username must be at least 2 characters';
                      }
                      return null;
                    },
                    decoration: _buildInputDecoration(
                      hintText: 'Username',
                      icon: Icons.person,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  if (errorMessage != null) ...[
                    const SizedBox(height: 15),
                    Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: AppDimens.fontMedium,
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusSmall,
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'ENTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppDimens.fontMedium,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}

// Anime Review Screen (เหมือนเดิม แต่ใช้ Constants และ AnimeDataProvider)
class AnimeReviewScreen extends StatefulWidget {
  const AnimeReviewScreen({Key? key}) : super(key: key);

  @override
  State<AnimeReviewScreen> createState() => _AnimeReviewScreenState();
}

class _AnimeReviewScreenState extends State<AnimeReviewScreen> {
  int? selectedAnimeId;
  late List<AnimeReview> animeReviews;
  int currentTab = 0; // 0 = gallery, 1 = favorites, 2 = profile

  @override
  void initState() {
    super.initState();
    animeReviews = AnimeDataProvider.getAllAnimes();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedAnimeId != null) {
      final anime = AnimeDataProvider.getAnimeById(selectedAnimeId!);
      if (anime == null) {
        return Scaffold(body: Center(child: Text('Anime not found')));
      }
      // Load persisted comments for this anime
      _loadCommentsForAnime(anime);
      return _buildDetailScreen(anime);
    }

    // Return appropriate screen based on tab
    switch (currentTab) {
      case 1:
        return _buildFavoritesScreen();
      case 2:
        return _buildProfileScreen();
      default:
        return _buildMainScreen();
    }
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.paddingLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ANIME',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                        ),
                        Text(
                          'REVIEWS',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        AuthService.logout();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingLarge,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => selectedAnimeId = 1),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.cardGradient,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusLarge,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(
                              width: 120,
                              height: 120,
                              color: AppColors.primary.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppDimens.paddingLarge),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppDimens.radiusMedium,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      animeReviews[0].imagePath,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      animeReviews[0].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          animeReviews[0].rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.amber,
                                            fontSize: AppDimens.fontMedium,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'อ่านรีวิว',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppDimens.fontSmall,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLarge,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: animeReviews.length - 1,
                    itemBuilder: (context, index) {
                      final anime = animeReviews[index + 1];
                      return GestureDetector(
                        onTap: () => setState(() => selectedAnimeId = anime.id),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusLarge,
                            ),
                            image: DecorationImage(
                              image: AssetImage(anime.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimens.radiusLarge,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppDimens.paddingMedium,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anime.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: AppDimens.fontMedium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        anime.rating.toString(),
                                        style: const TextStyle(
                                          color: Colors.amber,
                                          fontSize: AppDimens.fontSmall,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildFavoritesScreen() {
    final user = AuthService.getCurrentUser();
    final favorites = user?.favorites ?? [];
    final favoriteAnimes = favorites
        .map((id) => AnimeDataProvider.getAnimeById(id))
        .whereType<AnimeReview>()
        .toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.paddingLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FAVORITES',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                    ),
                    Icon(Icons.favorite, color: Colors.red.shade400, size: 28),
                  ],
                ),
              ),
              Expanded(
                child: favoriteAnimes.isEmpty
                    ? Center(
                        child: Text(
                          'No favorites yet',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: AppDimens.fontLarge,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(AppDimens.paddingMedium),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppDimens.paddingMedium,
                              crossAxisSpacing: AppDimens.paddingMedium,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: favoriteAnimes.length,
                        itemBuilder: (context, index) {
                          final anime = favoriteAnimes[index];
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedAnimeId = anime.id),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radiusLarge,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(anime.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  // Overlay gradient
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          AppDimens.radiusLarge,
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.8),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red.shade400,
                                      size: 20,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        AppDimens.paddingMedium,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            anime.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: AppDimens.fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                anime.rating.toString(),
                                                style: const TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: AppDimens.fontSmall,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileScreen() {
    final user = AuthService.getCurrentUser();
    final favoriteCount = user?.favorites.length ?? 0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (user?.username ?? 'User')[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user?.username ?? 'Unknown',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: favoriteCount > 0
                      ? () {
                          setState(() {
                            currentTab = 1;
                          });
                        }
                      : null,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingLarge,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDimens.radiusLarge,
                      ),
                      color: Colors.white.withOpacity(0.1),
                      border: favoriteCount > 0
                          ? Border.all(
                              color: AppColors.primary.withOpacity(0.5),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.paddingLarge),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Favorite Animes',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: AppDimens.fontMedium,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppDimens.radiusSmall,
                                  ),
                                  color: AppColors.primary,
                                ),
                                child: Text(
                                  '$favoriteCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: AppDimens.fontMedium,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          if (favoriteCount == 0)
                            Text(
                              'No favorites yet. Add some anime to your favorites!',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: AppDimens.fontSmall,
                              ),
                              textAlign: TextAlign.center,
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tap to view your favorites',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: AppDimens.fontSmall,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.primary,
                                  size: 16,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLarge,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppDimens.fontMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Anime Review App',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: AppDimens.fontSmall,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Discover and review your favorite anime',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: AppDimens.fontSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingLarge,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      AuthService.logout();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusSmall,
                        ),
                      ),
                    ),
                    child: const Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimens.fontMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentTab == 0 ? AppColors.primary : Colors.white54,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: currentTab == 1 ? Colors.red.shade400 : Colors.white54,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: currentTab == 2 ? AppColors.primary : Colors.white54,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailScreen(AnimeReview anime) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(anime.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, AppColors.darkBg],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => setState(() => selectedAnimeId = null),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusMedium,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anime.title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index < anime.rating.floor()
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            anime.rating.toString(),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: AppDimens.fontLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        anime.genre,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: AppDimens.fontSmall,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionContainer(
                        title: 'เรื่องย่อ',
                        content: anime.synopsis,
                      ),
                      const SizedBox(height: 20),
                      _buildSectionContainer(
                        title: 'รีวิว',
                        content: anime.review,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildProConContainer(
                              title: 'จุดเด่น',
                              items: anime.pros,
                              isPositive: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildProConContainer(
                              title: 'จุดด้อย',
                              items: anime.cons,
                              isPositive: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  setState(() => anime.toggleLike()),
                              icon: Icon(
                                anime.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: anime.isLiked
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              label: Text('${anime.likes}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimens.radiusMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showCommentDialog(anime),
                              icon: const Icon(Icons.comment, size: 20),
                              label: Text('${anime.commentCount}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimens.radiusMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () async {
                              final user = AuthService.getCurrentUser();
                              if (user != null) {
                                setState(() {
                                  if (user.isFavorite(anime.id)) {
                                    user.removeFavorite(anime.id);
                                  } else {
                                    user.addFavorite(anime.id);
                                  }
                                });
                                // Save favorites to persistent storage
                                await StorageService.saveFavorites(
                                  user.username,
                                  user.favorites,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      user.isFavorite(anime.id)
                                          ? 'Added to favorites'
                                          : 'Removed from favorites',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AuthService.getCurrentUser()?.isFavorite(
                                        anime.id,
                                      ) ??
                                      false
                                  ? Colors.red.shade700
                                  : AppColors.primary,
                              padding: const EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radiusMedium,
                                ),
                              ),
                            ),
                            child: Icon(
                              (AuthService.getCurrentUser()?.isFavorite(
                                        anime.id,
                                      ) ??
                                      false)
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Comments Section
                      if (anime.commentCount > 0) ...[
                        Text(
                          'Comments (${anime.commentCount})',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppDimens.fontLarge,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...anime.commentsList
                            .map(
                              (comment) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                    AppDimens.paddingMedium,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(
                                      AppDimens.radiusMedium,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            comment.username,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            _formatTime(comment.timestamp),
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: AppDimens.fontSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        comment.text,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          height: 1.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Future<void> _loadCommentsForAnime(AnimeReview anime) async {
    final savedComments = await StorageService.loadComments(anime.id);
    if (savedComments.isNotEmpty && anime.commentsList.isEmpty) {
      setState(() {
        anime.commentsList.addAll(savedComments);
      });
    }
  }

  void _showCommentDialog(AnimeReview anime) {
    final usernameController = TextEditingController();
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D1B3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Add Comment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Your Name',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Your Comment',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (usernameController.text.isNotEmpty &&
                  commentController.text.isNotEmpty) {
                setState(() {
                  anime.addComment(
                    usernameController.text,
                    commentController.text,
                  );
                });
                // Save comments to persistent storage
                await StorageService.saveComments(anime.id, anime.commentsList);
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Comment added!')));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppDimens.fontLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: AppDimens.fontMedium,
              height: 1.8,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildProConContainer({
    required String title,
    required List<String> items,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMedium),
      decoration: BoxDecoration(
        color: isPositive
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
        border: Border.all(
          color: isPositive
              ? Colors.greenAccent.withOpacity(0.3)
              : Colors.redAccent.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isPositive ? Colors.greenAccent : Colors.redAccent,
              fontSize: AppDimens.fontMedium,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPositive ? '✓' : '✗',
                    style: TextStyle(
                      color: isPositive ? Colors.greenAccent : Colors.redAccent,
                      fontSize: AppDimens.fontMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: AppDimens.fontSmall,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
