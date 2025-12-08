import 'package:flutter/material.dart';

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

class AnimeDataProvider {
  static final List<AnimeReview> animeReviews = [
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
    // ... (ส่วนที่เหลือ 19 รีวิวเดิม)
  ];

  static AnimeReview? getAnimeById(int id) {
    try {
      return animeReviews.firstWhere((anime) => anime.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<AnimeReview> getAllAnimes() {
    return List.from(animeReviews);
  }
}
