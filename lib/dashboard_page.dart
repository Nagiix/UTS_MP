import 'package:flutter/material.dart';
import 'create_activity_page.dart';
import 'create_user_page.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;

  DashboardPage({required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int totalData = 120;
  int totalUser = 5;
  int totalActivity = 32;

  String searchQuery = "";
  String selectedFilter = "Semua";

  List<Map<String, String>> activities = [
    {
      "title": "Login berhasil",
      "description": "Admin masuk ke aplikasi",
      "date": "10 Apr 2026",
      "type": "auth",
      "priority": "Sedang",
    },
    {
      "title": "Melihat dashboard",
      "description": "User membuka halaman dashboard",
      "date": "10 Apr 2026",
      "type": "view",
      "priority": "Rendah",
    },
    {
      "title": "Update profil",
      "description": "Data profil user diperbarui",
      "date": "09 Apr 2026",
      "type": "update",
      "priority": "Tinggi",
    },
    {
      "title": "Logout",
      "description": "User keluar dari aplikasi",
      "date": "09 Apr 2026",
      "type": "auth",
      "priority": "Rendah",
    },
  ];

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  void refreshData() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      totalData += 5;
      totalActivity += 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data berhasil diperbarui")),
    );
  }

  List<Map<String, String>> get filteredActivities {
    return activities.where((item) {
      final matchSearch = item["title"]!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchFilter = selectedFilter == "Semua" ||
          item["type"] == selectedFilter;

      return matchSearch && matchFilter;
    }).toList();
  }

  void openCreateActivityPage() async {
    final activity = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateActivityPage(),
      ),
    );

    if (activity != null) {
      setState(() {
        activities.insert(0, activity);
        totalActivity++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Aktivitas berhasil ditambahkan")),
      );
    }
  }

  Widget statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Interaktif"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async => refreshData(),

        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // GREETING
                Text(
                  "Halo, ${widget.username} 👋",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // STAT CARDS
                Row(
                  children: [
                    statCard("Data", "$totalData", Icons.storage),
                    SizedBox(width: 10),
                    statCard("User", "$totalUser", Icons.people),
                    SizedBox(width: 10),
                    statCard("Aktivitas", "$totalActivity", Icons.timeline),
                  ],
                ),

                SizedBox(height: 20),

                // BUTTON INTERAKTIF
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          totalData++;
                        });
                      },
                      child: Text("+ Data"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final isCreated = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateUserPage(),
                          ),
                        );

                        if (isCreated == true) {
                          setState(() {
                            totalUser++;
                            totalActivity++;
                          });
                        }
                      },
                      child: Text("+ User"),
                    ),
                    ElevatedButton(
                      onPressed: openCreateActivityPage,
                      child: Text("+ Aktivitas"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // SEARCH
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari aktivitas...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),

                SizedBox(height: 10),

                // FILTER CHIPS
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      filterChip("Semua"),
                      filterChip("auth"),
                      filterChip("view"),
                      filterChip("update"),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Aktivitas",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                // LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredActivities.length,
                  itemBuilder: (context, index) {
                    final item = filteredActivities[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.circle,
                            size: 10, color: Colors.blue),
                        title: Text(item["title"]!),
                        subtitle: Text(
                          [
                            item["description"],
                            item["date"],
                            item["type"],
                            item["priority"],
                          ]
                              .where((value) =>
                                  value != null && value.isNotEmpty)
                              .join(" - "),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterChip(String label) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selectedFilter == label,
        onSelected: (val) {
          setState(() {
            selectedFilter = label;
          });
        },
      ),
    );
  }
}
