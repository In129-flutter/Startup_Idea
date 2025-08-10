import 'dart:math';
import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';

class IdeaSubmissionScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const IdeaSubmissionScreen({super.key, required this.onToggleTheme});

  @override
  State<IdeaSubmissionScreen> createState() => _IdeaSubmissionScreenState();
}

class _IdeaSubmissionScreenState extends State<IdeaSubmissionScreen> {
  final _nameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitIdea() async {
    if (_nameController.text.isEmpty ||
        _taglineController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    int rating = Random().nextInt(101);
    Idea newIdea = Idea(
      id: DateTime.now().toString(),
      name: _nameController.text,
      tagline: _taglineController.text,
      description: _descriptionController.text,
      rating: rating,
      votes: 0,
    );

    await StorageService.saveIdea(newIdea);

    _nameController.clear();
    _taglineController.clear();
    _descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Idea submitted! Rating: $rating")),
    );

    Navigator.pushNamed(context, '/listing');
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required AppColors colors,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primaryBlue, width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context); // Current theme ke colors

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
        ],
        title: const Text("Submit Your Idea"),
        backgroundColor: colors.primaryBlue,
        foregroundColor: colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(
                  controller: _nameController,
                  label: "Startup Name",
                  colors: colors),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _taglineController,
                  label: "Tagline",
                  colors: colors),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _descriptionController,
                  label: "Description",
                  colors: colors),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitIdea,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primaryBlue,
                  foregroundColor: colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit Idea",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listing');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primaryBlue,
                  side: BorderSide(color: colors.primaryBlue),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Go to Listing Page",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primaryBlue,
                  side: BorderSide(color: colors.primaryBlue),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Go to Leaderboard",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
