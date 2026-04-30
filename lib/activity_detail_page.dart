import 'package:flutter/material.dart';
import 'create_activity_page.dart';

class ActivityDetailPage extends StatelessWidget {
  final Map<String, String> activity;

  ActivityDetailPage({required this.activity});

  Color priorityColor(String priority) {
    if (priority == "Tinggi") {
      return Colors.red;
    }
    if (priority == "Sedang") {
      return Colors.orange;
    }
    return Colors.green;
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value.isEmpty ? "-" : value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void openEditPage(BuildContext context) async {
    final updatedActivity = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateActivityPage(activity: activity),
      ),
    );

    if (updatedActivity != null) {
      Navigator.pop(context, updatedActivity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final priority = activity["priority"] ?? "Rendah";
    final color = priorityColor(priority);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Aktivitas"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => openEditPage(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    border: Border.all(color: color.withOpacity(0.45)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity["title"] ?? "-",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          priority,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                detailRow("Deskripsi", activity["description"] ?? ""),
                detailRow("Tanggal", activity["date"] ?? ""),
                detailRow("Tipe", activity["type"] ?? ""),
                detailRow("Prioritas", priority),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => openEditPage(context),
                    icon: Icon(Icons.edit),
                    label: Text("Edit Aktivitas"),
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
