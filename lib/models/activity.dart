class Activity {
  final String title;
  final String description;
  final String date;
  final String type;
  final String priority;

  Activity({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.priority,
  });

  Map<String, String> toMap() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "type": type,
      "priority": priority,
    };
  }

  static List<Map<String, String>> dummyList() {
    return [
      Activity(
        title: "Login berhasil",
        description: "Admin masuk ke aplikasi",
        date: "10 Apr 2026",
        type: "auth",
        priority: "Sedang",
      ).toMap(),
      Activity(
        title: "Melihat dashboard",
        description: "User membuka halaman dashboard",
        date: "10 Apr 2026",
        type: "view",
        priority: "Rendah",
      ).toMap(),
      Activity(
        title: "Update profil",
        description: "Data profil user diperbarui",
        date: "09 Apr 2026",
        type: "update",
        priority: "Tinggi",
      ).toMap(),
      Activity(
        title: "Logout",
        description: "User keluar dari aplikasi",
        date: "09 Apr 2026",
        type: "auth",
        priority: "Rendah",
      ).toMap(),
      Activity(
        title: "Tambah aktivitas",
        description: "Aktivitas baru dicatat",
        date: "08 Apr 2026",
        type: "update",
        priority: "Sedang",
      ).toMap(),
      Activity(
        title: "Melihat laporan",
        description: "User membuka daftar laporan",
        date: "08 Apr 2026",
        type: "view",
        priority: "Rendah",
      ).toMap(),
      Activity(
        title: "Validasi data",
        description: "Data aktivitas berhasil divalidasi",
        date: "07 Apr 2026",
        type: "update",
        priority: "Tinggi",
      ).toMap(),
      Activity(
        title: "Login gagal",
        description: "Percobaan login tidak valid",
        date: "07 Apr 2026",
        type: "auth",
        priority: "Tinggi",
      ).toMap(),
      Activity(
        title: "Membuka detail",
        description: "User melihat detail aktivitas",
        date: "06 Apr 2026",
        type: "view",
        priority: "Sedang",
      ).toMap(),
      Activity(
        title: "Edit aktivitas",
        description: "Informasi aktivitas diperbarui",
        date: "06 Apr 2026",
        type: "update",
        priority: "Sedang",
      ).toMap(),
    ];
  }
}
