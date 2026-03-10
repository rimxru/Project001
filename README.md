# Flutter Anime Application with Firebase

แอปพลิเคชันรวบรวมข้อมูลอนิเมะที่พัฒนาด้วย Flutter โดยมีการเชื่อมต่อกับ Firebase สำหรับระบบสมาชิกและการจัดการข้อมูล

## 🌟 Key Features
* **Authentication System:** ระบบสมัครสมาชิกและเข้าสู่ระบบผ่าน Firebase Auth
* **Anime Directory:** แสดงรายการอนิเมะยอดนิยมพร้อมรายละเอียด
* **Data Validation:** ระบบตรวจสอบความถูกต้องของข้อมูล (Email/Password) ก่อนทำการลงทะเบียน
* **Service-Oriented Architecture:** แยกส่วนการทำงานของ Logic (Auth, Storage, Validator) ออกจาก UI อย่างชัดเจน

## 💻 Tech Stack
* **Frontend:** Flutter & Dart
* **Backend:** Firebase Authentication
* **Data Management:** Dart Classes สำหรับจัดการโมเดลข้อมูลอนิเมะ

## 🚀 Getting Started
1. ติดตั้ง Flutter SDK และตั้งค่า Environment ให้เรียบร้อย
2. เชื่อมต่อโปรเจกต์กับ Firebase ผ่านไฟล์ `google-services.json`
3. รันคำสั่งเพื่อติดตั้ง Library:
   bash
   flutter pub get
รันแอปพลิเคชัน:

  bash
  flutter run

📂 Project Structure
lib/auth_service.dart: จัดการการ Login/Register ผ่าน Firebase

lib/anime_data.dart: เก็บโครงสร้างข้อมูลและรายชื่ออนิเมะ

lib/validators.dart: รวม Logic สำหรับตรวจสอบความถูกต้องของ Input

lib/storage_service.dart: ส่วนจัดการการจัดเก็บข้อมูลภายในแอปฯ
