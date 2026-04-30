import 'package:flutter/material.dart';

class CreateActivityPage extends StatefulWidget {
  final Map<String, String>? activity;

  CreateActivityPage({this.activity});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  String selectedType = "auth";
  String selectedPriority = "Sedang";

  final List<String> activityTypes = ["auth", "view", "update"];
  final List<String> priorityOptions = ["Rendah", "Sedang", "Tinggi"];

  @override
  void initState() {
    super.initState();
    final activity = widget.activity;

    if (activity == null) {
      dateController.text = formatDate(DateTime.now());
      return;
    }

    titleController.text = activity["title"] ?? "";
    descriptionController.text = activity["description"] ?? "";
    dateController.text = activity["date"] ?? formatDate(DateTime.now());
    selectedType = activity["type"] ?? selectedType;
    selectedPriority = activity["priority"] ?? selectedPriority;
  }

  String formatDate(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Agu",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];

    final day = date.day.toString().padLeft(2, "0");
    return "$day ${months[date.month - 1]} ${date.year}";
  }

  void saveActivity() {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      final activity = {
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "date": dateController.text.trim(),
        "type": selectedType,
        "priority": selectedPriority,
      };

      Navigator.pop(context, activity);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.activity == null ? "Create Aktivitas" : "Edit Aktivitas",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.activity == null
                        ? "Tambah aktivitas"
                        : "Edit aktivitas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.activity == null
                        ? "Aktivitas baru akan masuk ke daftar dashboard"
                        : "Perbarui data aktivitas",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Judul Aktivitas",
                      prefixIcon: Icon(Icons.timeline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Judul aktivitas wajib diisi";
                      }
                      if (value.trim().length < 3) {
                        return "Judul minimal 3 karakter";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.notes),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value != null &&
                          value.trim().isNotEmpty &&
                          value.trim().length < 5) {
                        return "Deskripsi minimal 5 karakter";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: "Tipe Aktivitas",
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: activityTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedType = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedPriority,
                    decoration: InputDecoration(
                      labelText: "Prioritas",
                      prefixIcon: Icon(Icons.flag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: priorityOptions.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedPriority = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: dateController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Tanggal",
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Tanggal wajib diisi";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      saveActivity();
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveActivity,
                      child: Text(
                        widget.activity == null
                            ? "Create Aktivitas"
                            : "Update Aktivitas",
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
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
}
