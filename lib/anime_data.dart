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
          "เรื่องราวของกัซ นักรบรับจ้างเจ้าของดาบยักษ์ที่มีชีวิตอยู่ท่ามกลางสนามรบตั้งแต่เกิด เขาได้พบกับ กรีฟีธ ชายหนุ่มรูปงามและเป็นหัวหน้ากองพันเหยี่ยว เรื่องราวจะพาเราดูมิตรภาพ ความฝัน และความรุ่งโรจน์ก่อนเหตุการณ์สุริยคราส",
      review:
          "หากคุณกำลังมองหาศิลปะชั้นครู ปรัชญาชีวิตที่ลึกซึ้ง และความดิบเถื่อนของมนุษย์ นี่คือเรื่องที่คุณต้องอ่านก่อนตาย ผลงานสำคัญที่เปลี่ยนวงการแมงงะและอนิเมะ",
      pros: ["ความดาร์ก", "งานภาพอลังการ", "เรื่องราวลึกซึ้ง"],
      cons: ["ฉากข่มขืน", "ภาพอวัยวะภายใน", "ยังไม่จบ"],
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
          "Thriller ที่ดีเยี่ยมกับแนวคิด dystopian ที่น่าคิด การสืบสวนแต่ละตอนน่าสนใจและมีความลึก ตัวละครหลักมีบุคลิกภาพที่แข็งแกร่ง แม้ว่า ending มีความคมชัด",
      pros: ["แนวคิด dystopian", "การสืบสวนน่าสนใจ", "ตัวละครที่ดี"],
      cons: ["Ending ค่อนข้างจบเร็ว"],
      likes: 1950,
      comments: 267,
    ),
    AnimeReview(
      id: 11,
      title: "Fairy Tail",
      imagePath: "assets/Fairy tail.jpg",
      rating: 4.8,
      genre: "Action, Comedy, Adventure",
      synopsis:
          "เรื่องราวสมาชิกของสมาคมเวทมนตร์ Fairy Tail ที่ออกผจญภัยเพื่อช่วยเหลือผู้คนและดำเนินการตามภารกิจต่างๆ",
      review:
          "อนิเมะผจญภัยที่เต็มไปด้วยมิตรภาพและแอคชั่น ตัวละครทั้งหมดมีเสน่ห์และน่ารัก ทำให้ผู้ชมติดตามแม้ว่าเรื่องบ้างจะคาดเดาได้ Ending ให้อารมณ์และ Soundtrack ดี",
      pros: ["เต็มไปด้วยมิตรภาพ", "Soundtrack ดี", "ตัวละครน่ารัก"],
      cons: ["บางส่วนเรื่องคาดเดาได้"],
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
          "ชินระ นักดับเพลิงรุ่นเยาว์พยายามเข้าสู่หน่วยดับเพลิงชั้นนำเพื่อหาความจริงเกี่ยวกับการเสียชีวิตของครอบครัวของเขา",
      review:
          "อนิเมะแอคชั่นสุดระทึกกับความตลกที่สดใส ความสมดุลระหว่างบรรยากาศมืดมนและความสนุกสนาน Animation ในบางตอนดีมาก การต่อสู้ที่สร้างสรรค์และน่าเร้าใจ",
      pros: ["ความตลกที่ดี", "Animation ยอดเยี่ยม", "Action สุดระทึก"],
      cons: ["บางครั้งจังหวะค่อนข้างเร็ว"],
      likes: 2800,
      comments: 389,
    ),
    AnimeReview(
      id: 13,
      title: "Kaijuu 8",
      imagePath: "assets/Kaijuu 8.jpg",
      rating: 4.5,
      genre: "Action, Adventure, Military",
      synopsis:
          "โคฮ นักกำจัดสิ่งปรับปรุง 32 ปีได้รับพลังลึกลับจากสัตว์ประหลาดและเข้าร่วมหน่วยทหารเพื่อปกป้องโลก",
      review:
          "อนิเมะแอคชั่นที่เขียนดีกับตัวละครที่มีความลึก เนื้อเรื่องเกี่ยวกับการพัฒนาตัวเองและการท้าทายตัวเอง Animation ดีและการต่อสู้ที่ระทึกใจ",
      pros: ["ตัวละครน่ารัก", "Soundtrack ตระนัก", "เรื่องราวบันดาลใจ"],
      cons: ["Pacing บ้างไม่สม่ำเสมอ"],
      likes: 2950,
      comments: 412,
    ),
    AnimeReview(
      id: 14,
      title: "Vinland Saga",
      imagePath: "assets/Vinland Saga.jpg",
      rating: 4.9,
      genre: "Action, Adventure, Historical, Drama",
      synopsis:
          "ธอร์ฟิน นักรบไวกิ้งยุ่งกับการแก้แค้นเพื่อผู้ที่ฆ่าพ่อของเขา แต่จะหาทางสู่ทางสำเร็จของเขา",
      review:
          "Epic ที่ยอดเยี่ยมกับตัวเอกที่มีการพัฒนาลึกซึ้ง ภาพสวยงาม บรรยากาศ historical ที่อ่อนไหว ดนตรีและ cinematography ระดับสูง Pacing อาจช้าสำหรับบางคน แต่เรื่องราวคุ้มค่า",
      pros: ["ตัวเอกพัฒนา", "บรรยากาศ historical", "Cinematography ยอดเยี่ยม"],
      cons: ["ความรุนแรงมากเกินไป"],
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
          "เดนจิ เด็กหนุ่มผ่านการเปลี่ยนแปลงและได้รับพลังพิศวาสเพื่อให้บรรลุฝันของเขา",
      review:
          "Gory action ที่ตื่นเต้นและเต็มไปด้วยอารมณ์ ตัวละครน่าจดจำ ดนตรีพังก์ที่เหมาะสม Animation อันแข็งแรงคือแรงบันดาลใจ เนื้อเรื่องก้าวหน้าได้อย่างรวดเร็วและน่าติดตาม",
      pros: ["Action สุดระทึก", "ตัวละครจำได้", "Soundtrack punk"],
      cons: ["ความรุนแรงระดับสูง"],
      likes: 2650,
      comments: 356,
    ),
    AnimeReview(
      id: 16,
      title: "Spy x Family",
      imagePath: "assets/Spy x Family.jpg",
      rating: 4.6,
      genre: "Action, Comedy, School",
      synopsis:
          "สายลับ พลเมืองแฝงตัว และแม่มดได้ถูกจัดให้เป็นครอบครัวเพื่อให้ทำภารกิจได้สำเร็จ",
      review:
          "Comedy และ action ที่สมดุลกันได้ดี ตัวละครน่ารักและมีเสน่ห์ บรรยากาศอบอุ่นแม้ว่าฉากที่เต็มไปด้วยแอคชั่น Animation ดี Pacing ดี ทั้งหมดทำให้มีความสุข",
      pros: ["ความสมดุล comedy-action", "ตัวละครเสน่ห์", "บรรยากาศอบอุ่น"],
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
      synopsis: "โงน นักเรียนวัยรุ่นผจญภัยเพื่อหาพ่อและสำรวจโลกว่างเปล่า",
      review:
          "Adventure shounen ที่ยอดเยี่ยมกับ worldbuilding ที่ดี ตัวละครทั้งหมดมีการพัฒนาที่เหลือเชื่อ ทุกส่วนของเรื่องมีความหมาย Arc แต่ละเรื่องเลือดวนและ Ending สุดปัง",
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
      synopsis:
          "พี่น้องชายหญิงพยายามใช้วิทยาศาสตร์เวทมนตร์เพื่อคืนตัวของพวกเขา",
      review:
          "Masterpiece ของ shounen anime กับเนื้อเรื่องตั้งแต่ต้นถึงจบที่ดีเยี่ยม ตัวละครและการพัฒนาทำได้อย่างสมบูรณ์แบบ ทุกส่วนขยายได้ดี Ending บอกใจได้ดี ดนตรียอดเยี่ยม ต้องดู",
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
      genre: "Action, Comedy, School",
      synopsis:
          "ซากามโต้ นักเรียนที่สุด์จัดใจใจคณลักษณ์มเนิ่นดีที่สุดอยู่ในชีวิตสมัยเรียน",
      review:
          "Manga adaptation ที่มีศักยภาพสูง ภาพสวยและ worldbuilding ที่ซับซ้อน ตัวละครเหมาะสมและ character development ดี ความสมดุลระหว่างแอคชั่นและความตลกทำให้อนิเมะนี้มีเอกลักษณ์",
      pros: ["Comedy ดี", "Animation ดี", "ตัวละครพัฒนา"],
      cons: ["บางส่วนจังหวะอาจเร็วไป"],
      likes: 1820,
      comments: 245,
    ),
    AnimeReview(
      id: 20,
      title: "Solo Leveling",
      imagePath: "assets/Solo Leveling.jpg",
      rating: 4.5,
      genre: "Action, Adventure, Fantasy",
      synopsis:
          "ซองจินวู นักล่าอ่อนแอที่เข้าห้องวิวัฒนาการลึกลับและได้รับพลังเพิ่มเติม",
      review:
          "Manhwa adaptation ที่ยอดเยี่ยม ศิลปศาสตร์ animation สัดส่วนยอดเยี่ยม การต่อสู้ที่ระทึกใจ ตัวละครหลักมี growth ที่ก้าวกระหาง ดนตรีใช้ได้ดี ความรวดเร็วของเนื้อเรื่องทำให้ติดตาม",
      pros: ["Animation ยอดเยี่ยม", "Action สุดระทึก", "Pacing ดี"],
      cons: ["ตัวละครรอบข้างยังอ่อน"],
      likes: 2740,
      comments: 378,
    ),
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
