import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';

class LeaderboardScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const LeaderboardScreen({super.key, required this.onToggleTheme});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Idea> topIdeas = [];

  @override
  void initState() {
    super.initState();
    _loadTopIdeas();
  }

  void _loadTopIdeas() async {
    List<Idea> allIdeas = await StorageService.getIdeas();
    allIdeas.sort((a, b) => b.votes.compareTo(a.votes));
    setState(() {
      topIdeas = allIdeas.take(5).toList();
    });
  }

  Widget _buildMedal(int index) {
    if (index == 0) return const Text("🥇", style: TextStyle(fontSize: 24));
    if (index == 1) return const Text("🥈", style: TextStyle(fontSize: 24));
    if (index == 2) return const Text("🥉", style: TextStyle(fontSize: 24));
    return const SizedBox();
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
        title: const Text("Leaderboard"),
        backgroundColor: colors.primaryBlue,
        foregroundColor: colors.white,
      ),
      body: ListView.builder(
        itemCount: topIdeas.length,
        itemBuilder: (context, index) {
          final idea = topIdeas[index];
          return Card(
            color: colors.white,
            margin: const EdgeInsets.all(8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: _buildMedal(index),
              title: Text(
                idea.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.textDark,
                ),
              ),
              subtitle: Text(
                "${idea.tagline}\nVotes: ${idea.votes} | Rating: ${idea.rating}",
                style: TextStyle(color: colors.textDark),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
