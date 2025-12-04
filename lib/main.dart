import 'package:flutter/material.dart';
import 'auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await AuthService.login(
      email: emailController.text,
      password: passwordController.text,
    );

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B4C7C), Color(0xFF2D1B3D), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ANIME REVIEWS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFB497CC)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFB497CC)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                if (errorMessage != null) ...[
                  SizedBox(height: 15),
                  Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB497CC),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFFB497CC),
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}

// Signup Screen
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signup() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final result = await AuthService.signup(
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account created! Please login.')));
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      setState(() {
        errorMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B4C7C), Color(0xFF2D1B3D), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.person, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFB497CC)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.email, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFB497CC)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password (min 6 characters)',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFB497CC)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFB497CC)),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  if (errorMessage != null) ...[
                    SizedBox(height: 15),
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isLoading ? null : signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB497CC),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFB497CC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Anime Review Screen - หน้าหลักรีวิวอนิเมะ
class AnimeReviewScreen extends StatefulWidget {
  const AnimeReviewScreen({Key? key}) : super(key: key);

  @override
  State<AnimeReviewScreen> createState() => _AnimeReviewScreenState();
}

class _AnimeReviewScreenState extends State<AnimeReviewScreen> {
  int? selectedAnimeId;

  final List<AnimeReview> animeReviews = [
    AnimeReview(
      id: 1,
      title: "The Apothecary Diaries",
      imagePath: "assets/The Apothecary Diaries.jpg",
      rating: 4.8,
      genre: "Mystery, Historical",
      synopsis:
          "เรื่องราวของเหมาเหมา เภสัชกรสาวผู้ถูกลักพาตัวมาทำงานในราชสำนัก ด้วยความรู้ทางเภสัชศาสตร์และทักษะการสืบสวน เธอต้องไขปริศนาต่างๆ ที่เกิดขึ้นในวังหลวง",
      review:
          "อนิเมะที่มีเนื้อเรื่องน่าติดตามมาก ตัวเอกน่ารักและฉลาด การแก้ปริศนาแต่ละตอนทำได้อย่างชาญฉลาด ภาพสวยงามและดนตรีประกอบเข้ากับบรรยากาศยุคโบราณได้ดีมาก แนะนำสำหรับคนชอบแนว Mystery!",
      pros: ["เนื้อเรื่องน่าสนใจ", "ตัวละครมีเสน่ห์", "ภาพสวยงาม"],
      cons: ["บางตอนช้าไปนิด"],
      likes: 1250,
      comments: 89,
    ),
    AnimeReview(
      id: 2,
      title: "Death Note",
      imagePath: "assets/Death Note.jpg",
      rating: 4.9,
      genre: "Psychological, Thriller",
      synopsis:
          "ไลท์ ยากามิ นักเรียนมัธยมปลายอัจฉริยะ พบสมุดโน้ตลึกลับที่สามารถฆ่าคนได้ด้วยการเขียนชื่อ เขาตัดสินใจใช้พลังนี้กำจัดอาชญากรและสร้างโลกใหม่",
      review:
          "ผลงานคลาสสิกที่ไม่มีวันเสื่อมคลาย การดวลสมองระหว่างไลท์กับ L ทำให้ตื่นเต้นทุกตอน บทภาพยนตร์เขียนได้อย่างชาญฉลาด ทุก twist น่าตกใจ เป็นหนึ่งใน top psychological anime ตลอดกาล!",
      pros: ["บทเขียนยอดเยี่ยม", "การดวลสมองสุดระทึก", "ตัวละครน่าจดจำ"],
      cons: ["ครึ่งหลังเนื้อเรื่องตกต่ำลงเล็กน้อย"],
      likes: 2840,
      comments: 342,
    ),
    AnimeReview(
      id: 3,
      title: "Blue Lock",
      imagePath: "assets/Blue Lock.jpg",
      rating: 4.5,
      genre: "Sports, Shounen",
      synopsis:
          "โครงการฝึกอบรมแข้งรุ่นเยาว์ของญี่ปุ่นที่รวบรวม 300 คนมาฝึกฝนเพื่อหาผู้ที่จะเป็นกองหน้าเอโกอิสต์ที่ยิ่งใหญ่ที่สุด",
      review:
          "อนิเมะฟุตบอลที่แตกต่างจากเดิมอย่างสิ้นเชิง ไม่ใช่แค่เพื่อนร่วมทีม แต่เป็นการแข่งขันเอาตัวรอด! คอนเซ็ปต์ใหม่และน่าสนใจมาก แม้ว่าภาพเคลื่อนไหวจะไม่เพอร์เฟกต์ แต่เนื้อเรื่องทำให้ติดตามได้",
      pros: ["คอนเซ็ปต์ใหม่", "ตัวละครหลากหลาย", "ทำให้ตื่นเต้น"],
      cons: ["Animation บางช่วงไม่ค่อยดี"],
      likes: 1680,
      comments: 156,
    ),
    AnimeReview(
      id: 4,
      title: "Frieren",
      imagePath: "assets/Frieren Beyond Journey.jpg",
      rating: 5.0,
      genre: "Fantasy, Adventure, Drama",
      synopsis:
          "หลังจากเอาชนะจอมมารและสิ้นสุดการผจญภัย เฟรเรน เอลฟ์ผู้มีชีวิตยืนยาวได้เริ่มเดินทางใหม่เพื่อทำความเข้าใจมนุษย์และความทรงจำที่เธอมีร่วมกับเพื่อนร่วมทาง",
      review:
          "ผลงานชิ้นเอกแห่งปี! เรื่องราวที่สวยงามและอบอุ่นหัวใจ แตกต่างจากอนิเมะ fantasy ทั่วไปตรงที่มันเน้นไปที่อารมณ์และความสัมพันธ์ของตัวละคร ภาพสวยสุดๆ ดนตรีไพเราะ และทุกตอนมีความหมาย ต้องดู!",
      pros: [
        "เนื้อเรื่องลึกซึ้ง",
        "ภาพสวยงามระดับ cinema",
        "ดนตรียอดเยี่ยม",
        "ให้อารมณ์ดี",
      ],
      cons: ["ไม่มีข้อเสียเลย"],
      likes: 3250,
      comments: 428,
    ),
    AnimeReview(
      id: 5,
      title: "Jujutsu Kaisen",
      imagePath: "assets/jujutsu kaisen.jpg",
      rating: 4.7,
      genre: "Action, Supernatural, School",
      synopsis:
          "ยูจิ ยูกิ นักเรียนมัธยมปลายธรรมดาถูกเรียกเข้าสู่โลกเวทมนตร์ได้รับปีศาจโรงงานบรรจุภัณฑ์เข้าไปในตัว",
      review:
          "Animation ยอดเยี่ยม บทต่อสู้ตื่นเต้นสุดขีด ตัวละครมีเสน่ห์ และเนื้อเรื่องติดตามได้ดี ส่วนประกอบทุกด้านสมดุลกันเป็นอนิเมะ shounen ที่ดีที่สุด",
      pros: ["Animation ดี", "Action สุดระทึก", "ตัวละครน่ารัก"],
      cons: ["บางตอนช้าไป"],
      likes: 2950,
      comments: 387,
    ),
    AnimeReview(
      id: 6,
      title: "Attack on Titan",
      imagePath: "assets/Attack on Titan.jpg",
      rating: 4.8,
      genre: "Action, Drama, Fantasy",
      synopsis:
          "มนุษย์ต่างถูกผนึกไว้ภายในกำแพงเพื่อป้องกันจาก Titans สัตว์ประหลาดยักษ์ที่กินคน",
      review:
          "ผลงาน epic ที่ชี้นำวิธีคิดใหม่ของอนิเมะ ทุก twist ที่เกิดขึ้นน่าตกใจและน่าคิด เนื้อเรื่องลึกลับและชวนสงสัย ตัวละครพัฒนาตัวเองตลอดเรื่อง หนึ่งใน top anime ตลอดกาล",
      pros: ["เนื้อเรื่องลึกลับ", "Twists สุดระทึก", "Ending โปรดปรานรส"],
      cons: ["ความรุนแรงบางครั้งมากเกินไป"],
      likes: 3420,
      comments: 512,
    ),
    AnimeReview(
      id: 7,
      title: "Tokyo Ghoul",
      imagePath: "assets/Tokyo Ghoul.jpg",
      rating: 4.3,
      genre: "Action, Horror, Supernatural",
      synopsis:
          "โลกที่มี Ghouls สิ่งมีชีวิตโลหิตกระหายอาศัยอยู่ ตนุกิ ชายหนุ่มธรรมชาติกลายเป็น Ghoul ครึ่งตัวและต้องสอบตัวอยู่เสมอ",
      review:
          "เรื่องราวที่มืดมนและน่ากลัว Animation ดีและสัญชาตญาณเสริม ทำให้ผู้ชมรู้สึกไม่สบายใจตลอดเรื่อง ตัวละครหลักมีการพัฒนาที่ประเมินไม่ได้",
      pros: ["บรรยากาศอันสยดสยอง", "Animation เลิศ", "ตัวละครที่พัฒนา"],
      cons: ["Pacing ไม่สม่ำเสมอ"],
      likes: 2240,
      comments: 298,
    ),
    AnimeReview(
      id: 8,
      title: "Demon Slayer",
      imagePath: "assets/Demon slayer.jpg",
      rating: 4.6,
      genre: "Action, Adventure, Shounen",
      synopsis:
          "ทันจิโร นักล่าปีศาจต่อสู้เพื่อบำรุงน้องสาวของเขาที่ติดสารพิษปีศาจ",
      review:
          "Animation ที่ไร้ประมาณและสวยงาม ทุกการต่อสู้ดูราวกับการแสดงบัลเล่ต์ Choreography ของการต่อสู้ยอดเยี่ยม ตัวละครน่ารัก ดนตรีดี แต่เนื้อเรื่องค่อนข้างง่ายสำหรับผู้ชม",
      pros: ["Animation ไร้ประมาณ", "การต่อสู้สวยงาม", "Soundtrack ดี"],
      cons: ["เนื้อเรื่องค่อนข้างง่าย"],
      likes: 3100,
      comments: 445,
    ),
    AnimeReview(
      id: 9,
      title: "Berserk",
      imagePath: "assets/Berserk.jpg",
      rating: 5.0,
      genre: "Dark Fantasy, Action, Drama, Horror, Seinen",
      synopsis:
          "เรื่องราวของกัซ(Guts) นักรบรับจ้างเจ้าของดาบยักษ์Dragon Slayerที่มีชีวิตอยู่ท่ามกลางสนามรบตั้งแต่เกิด เขาได้พบกับ กรีฟีธ(Griffith) ชายหนุ่มรูปงามผู้เปี่ยมด้วยความทะเยอทะยานและเป็นหัวหน้ากองพันเหยี่ยว (Band of the Hawk)เรื่องราวจะพาเราย้อนไปดูมิตรภาพ ความฝัน และความรุ่งโรจน์ของพวกเขาก่อนที่จะเกิดเหตุการณ์สุริยคราส(The Eclipse)ซึ่งเปลี่ยนชีวิตของกัซและโลกทั้งใบให้กลายเป็นนรกบนดิน ทำให้กัซต้องออกเดินทางเพื่อแก้แค้นและปกป้องสิ่งที่เหลืออยู่ ในฐานะมนุษย์ธรรมดาที่ประกาศสงครามกับปีศาจและโชคชะตา",
      review:
          "หากคุณกำลังมองหาการ์ตูนที่ โลกสวยให้หนีไปให้ไกล แต่ถ้าคุณมองหา ศิลปะชั้นครู ปรัชญาชีวิตที่ลึกซึ้ง และความดิบเถื่อนของมนุษย์ นี่คือเรื่องที่คุณต้องอ่านก่อนตายครับ",
      pros: ["ความดาร์ก, งานภาพอลังการ, เรื่องราวการต่อสู้ชีวิตที่เข้มข้น และรับได้กับความรุนแรงระดับสูง -> ห้ามพลาดเด็ดขาด"],
      cons: ["ฉากข่มขืน, ภาพอวัยวะภายใน, การ์ตูนที่หดหู่สิ้นหวัง หรือเรื่องที่ยังไม่จบบริบูรณ์ 100% -> ควรหลีกเลี่ยง"],
      likes: 2680,
      comments: 356,
    ),
    AnimeReview(
      id: 10,
      title: "Cyberpunk",
      imagePath: "assets/Cyberpunk.jpg",
      rating: 4.5,
      genre: "Sci-Fi, Police, Thriller",
      synopsis:
          "ในอนาคตที่ระบบสามารถวัดระดับความเป็นอาชญากรของบุคคล ตำรวจต้องหาผู้ร้ายก่อนที่เขาจะก่ออาชญากรรม",
      review:
          "Thriller ที่ดีเยี่ยมกับแนวคิด dystopian ที่น่าคิดถึง การสืบสวนแต่ละตอนน่าสนใจและมีความลึก ตัวละครหลักมีขนาด แม้ว่า ending มีความคมชัด",
      pros: ["แนวคิด dystopian", "การสืบสวนน่าสนใจ", "ตัวละครที่ดี"],
      cons: ["Ending ค่อนข้างเหมือนจบเร็ว"],
      likes: 1950,
      comments: 267,
    ),
    AnimeReview(
      id: 11,
      title: "Fairy tail",
      imagePath: "assets/Fairy tail.jpg",
      rating: 4.8,
      genre: "Action, Comedy, School",
      synopsis:
          "โมบ เด็กอัจฉริยะที่มีพลัง psychic ทรงพลังพยายามใช้ชีวิตปกติเหมือนเด็กคนอื่นๆ",
      review:
          "Comedy ที่ดีเยี่ยมผสมกับ action ที่ยอดเยี่ยม ตัวละครหลักน่ารักมากและเรียนรู้ชีวิต ศิลปศาสตร์ animation ที่ไม่ธรรมดา Soundtrack ที่ดี Ending มีอารมณ์มาก",
      pros: ["Comedy ยอดเยี่ยม", "Soundtrack ดี", "ตัวละครน่ารักที่สุด"],
      cons: ["ไม่มีข้อเสีย"],
      likes: 2420,
      comments: 334,
    ),
    AnimeReview(
      id: 12,
      title: "Fire Force",
      imagePath: "assets/Fire Force.jpg",
      rating: 4.4,
      genre: "Action, Comedy, Superhero",
      synopsis:
          "สายตะ นักเรียนธรรมดาผ่านการฝึกหนัก กลายเป็นนักสู้ที่สามารถพ่ายแพ่งทุกๆ ศัตรูได้ด้วยปลดหมัดเดียว",
      review:
          "Parody ของ superhero anime ที่อันเป็นมสุดสนุก ความตลกที่ดีและการต่อสู้ที่ยิ่งใหญ่ Animation ในเรื่องแรกเป็นยอดเยี่ยม แต่ครั้งที่สองตัวต่างกันมากในคุณภาพ",
      pros: ["ความตลกที่ดี", "Animation ยอดเยี่ยม", "Action สุดระทึก"],
      cons: ["Season 2 animation ไม่ดีเท่า Season 1"],
      likes: 2800,
      comments: 389,
    ),
    AnimeReview(
      id: 13,
      title: "Kaijuu 8",
      imagePath: "assets/Kaijuu 8.jpg",
      rating: 4.5,
      genre: "Action, Adventure, School",
      synopsis:
          "ใจ์โดะ เด็กไม่มีพลังแม้จะเกิดในยุคที่คนส่วนใหญ์มีพลังพิเศษ แต่เขาฝันว่าจะเป็น hero",
      review:
          "Shounen ที่เขียนดีกับเนื้อเรื่องเกี่ยวกับการเติบโตและความมุ่งมั่น ตัวละครและเพื่อนทั้งหมดให้กำลังใจและ likeable มาก Animation ส่วนใหญ่ดีแต่บางตอนช่วยได้",
      pros: ["ตัวละครน่ารัก", "Soundtrack ตระนัก", "เรื่องราวที่บันดาลใจ"],
      cons: ["Pacing ไม่สม่ำเสมอ"],
      likes: 2950,
      comments: 412,
    ),
    AnimeReview(
      id: 14,
      title: "Vinland Saga",
      imagePath: "assets/Vinland Saga.jpg",
      rating: 4.9,
      genre: "Action, Adventure, Historical",
      synopsis: "ธอร์ฟิน นักรบไวกิ้งยุ่งกับการแก้แค้นและค้นหาตัวของเขาเอง",
      review:
          "Epic ที่ยอดเยี่ยมกับตัวเอกที่มีการพัฒนาลึกซึ้ง ภาพสวยงาม บรรยากาศ historical ที่อ่อนไหว ดนตรีและ cinematography ระดับสูง Pacing อาจช้าสำหรับบางคน แต่เรื่องราวคุ้มค่า",
      pros: [
        "ตัวเอกที่มีพัฒนา",
        "บรรยากาศ historical",
        "Cinematography ยอดเยี่ยม",
      ],
      cons: ["ความรุนแรงบางครั้งมากเกินไป"],
      likes: 2340,
      comments: 298,
    ),
    AnimeReview(
      id: 15,
      title: "Chainsaw Man",
      imagePath: "assets/Chainsaw Man.jpg",
      rating: 4.7,
      genre: "Action, Dark Fantasy, Shounen",
      synopsis:
          "เดนจิ เด็กหนุ่มผ่านการเปลี่ยนแปลงเป็นอะไรที่ประหลาด เพื่อให้บรรลุฝัน",
      review:
          "Gory action ที่ตื่นเต้นและอารมณ์ ตัวละครน่าจดจำ ดนตรีพังก์ที่เหมาะสม Animation อันแข็งแรงคือแรงบันดาลใจอดทน เนื้อเรื่องก้าวหน้าได้อย่างรวดเร็ว",
      pros: [
        "Action สุดระทึก",
        "ตัวละครที่ทำให้จำ",
        "Soundtrack punk ที่ถูกใจ",
      ],
      cons: ["ความรุนแรง"],
      likes: 2650,
      comments: 356,
    ),
    AnimeReview(
      id: 16,
      title: "Spy x Family",
      imagePath: "assets/Spy x Family.jpg",
      rating: 4.6,
      genre: "Action, Comedy, School",
      synopsis: "สายลับ พลเมืองแฝงตัว และแม่มดได้ถูกจัดให้เป็นครอบครัว",
      review:
          "Comedy และ action ที่สมดุลกันได้ดี ตัวละครน่ารักและมีเสน่ห์ บรรยากาศอบอุ่นแม้เรื่องนี้เป็นเรื่องเชิงนาทีจริงๆ Animation ดี Pacing ดี ทั้งหมดทำให้เรื่องนี้มีความสุข",
      pros: [
        "ความสมดุลระหว่าง comedy และ action",
        "ตัวละครมีเสน่ห์",
        "บรรยากาศอบอุ่น",
      ],
      cons: ["ไม่มี"],
      likes: 2890,
      comments: 423,
    ),
    AnimeReview(
      id: 17,
      title: "Hunter x Hunter",
      imagePath: "assets/Hunter x Hunter.jpg",
      rating: 4.8,
      genre: "Adventure, Action, Shounen",
      synopsis:
          "โงน นักเรียนวัยรุ่นสนใจในการทำ hunter ต่อสู้เพื่อค้นหาพ่อของเขา",
      review:
          "Adventure shounen ที่ยอดเยี่ยมกับจักรวาล worldbuilding ที่ดี ตัวละครโดยรวมมีการพัฒนาที่ยอดเยี่ยม ทุกส่วนของเรื่องมีความหมาย Ending หนึ่งในผลงาน shonen ที่ดีที่สุด",
      pros: ["Worldbuilding ดี", "ตัวละครพัฒนา", "Ending ยอดเยี่ยม"],
      cons: ["Animation บางตอนไม่ดี"],
      likes: 3050,
      comments: 467,
    ),
    AnimeReview(
      id: 18,
      title: "Fullmetal Alchemist",
      imagePath: "assets/Fullmetal alchemist.jpg",
      rating: 4.9,
      genre: "Action, Adventure, Fantasy",
      synopsis: "พี่น้องชายหญิงพยายามใช้ alchemy เพื่อคืนตัวของพวกเขา",
      review:
          "Masterpiece ของ shounen anime กับเนื้อเรื่องตั้งแต่ต้นถึงจบที่ดีเยี่ยม ตัวละครและการพัฒนาได้ทำได้อย่างยอดเยี่ยม ทุกส่วนขยายได้ดี Ending บอกใจได้ดี ดนตรียอดเยี่ยม ต้องดูอย่างแน่นอน",
      pros: ["Ending ยอดเยี่ยม", "ตัวละครพัฒนา", "Soundtrack ไพเราะ"],
      cons: ["ไม่มีข้อเสีย"],
      likes: 3380,
      comments: 512,
    ),
    AnimeReview(
      id: 19,
      title: "SAKAMOTODAYS",
      imagePath: "assets/SAKAMOTODAYS.jpg",
      rating: 4.4,
      genre: "Action, Adventure, Fantasy",
      synopsis: "บาห์ เด็กหนุ่มปีนหอคอยลึกลับเพื่อหาเพื่อนของเขา",
      review:
          "Webtoon adaptation ที่มีศักยภาพสูง ภาพสวยและ worldbuilding ที่ซับซ้อน ตัวละครเหมาะสมและ character development ดี ส่วนดำเนินเรื่องบางครั้งมึนงง แต่เรื่องนี้มีศักยภาพเต็มที่",
      pros: ["Worldbuilding ที่ซับซ้อน", "Animation ดี", "ตัวละครที่พัฒนา"],
      cons: ["ส่วนดำเนินเรื่องบางครั้งสับสน"],
      likes: 1820,
      comments: 245,
    ),
    AnimeReview(
      id: 20,
      title: "Solo Leveling",
      imagePath: "assets/Solo Leveling.jpg",
      rating: 4.5,
      genre: "Action, Adventure, Fantasy",
      synopsis: "ซองจินวู นักรบอ่อนแอที่เขาเข้าห้องวิวัฒนาการและเกิดอีกครั้ง",
      review:
          "Manhwa adaptation ที่ยอดเยี่ยม ศิลปศาสตร์ animation สัดส่วนยอดเยี่ยม การต่อสู้ที่ระทึกใจ ตัวละครหลักมีสปีด growth ที่โจมตีและทำให้สนใจ ดนตรีใช้ได้ดี ความรวดเร็วและการปราศรัยทำให้มันติดตาม",
      pros: ["Animation ยอดเยี่ยม", "Action สุดระทึก", "Pacing ดี"],
      cons: ["ตัวละครรอบข้างอ่อน"],
      likes: 2740,
      comments: 378,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedAnimeId != null) {
      final anime = animeReviews.firstWhere((a) => a.id == selectedAnimeId);
      return _buildDetailScreen(anime);
    }
    return _buildMainScreen();
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6B4C7C), Color(0xFF4A3960), Color(0xFF2D1B3D)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ANIME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'REVIEWS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.white, size: 28),
                      onPressed: () {
                        AuthService.logout();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    ),
                  ],
                ),
              ),

              // Featured Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedAnimeId = 1),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B6FA8), Color(0xFF4A3960)],
                      ),
                      borderRadius: BorderRadius.circular(20),
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
                              color: Color(0xFFB497CC).withOpacity(0.5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      animeReviews[0].title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          animeReviews[0].rating.toString(),
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFB497CC),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'อ่านรีวิว',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
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

              SizedBox(height: 30),

              // Grid of anime cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(anime.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anime.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        anime.rating.toString(),
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 12,
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
    );
  }

  Widget _buildDetailScreen(AnimeReview anime) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6B4C7C), Color(0xFF4A3960), Color(0xFF2D1B3D)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
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
                            colors: [Colors.transparent, Color(0xFF2D1B3D)],
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Rating
                      Text(
                        anime.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
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
                          SizedBox(width: 8),
                          Text(
                            anime.rating.toString(),
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        anime.genre,
                        style: TextStyle(
                          color: Color(0xFFB497CC),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Synopsis
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'เรื่องย่อ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              anime.synopsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Review
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'รีวิว',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              anime.review,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Pros and Cons
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'จุดเด่น',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ...anime.pros.map(
                                    (pro) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        '✓ $pro',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'จุดด้อย',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ...anime.cons.map(
                                    (con) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        '✗ $con',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up, size: 20),
                              label: Text('${anime.likes}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFB497CC),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.comment, size: 20),
                              label: Text('${anime.comments}'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFB497CC),
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFB497CC),
                              padding: EdgeInsets.all(14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Icon(Icons.share, size: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
}

class AnimeReview {
  final int id;
  final String title;
  final String imagePath;
  final double rating;
  final String genre;
  final String synopsis;
  final String review;
  final List<String> pros;
  final List<String> cons;
  final int likes;
  final int comments;

  AnimeReview({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.genre,
    required this.synopsis,
    required this.review,
    required this.pros,
    required this.cons,
    required this.likes,
    required this.comments,
  });
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
