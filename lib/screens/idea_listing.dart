import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';

class IdeaListingScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const IdeaListingScreen({super.key, required this.onToggleTheme});

  @override
  State<IdeaListingScreen> createState() => _IdeaListingScreenState();
}

class _IdeaListingScreenState extends State<IdeaListingScreen> {
  List<Idea> ideas = [];
  Set<String> votedIdeas = {};
  Set<String> expandedIdeas = {};
  String sortBy = "votes";

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  Future<void> _loadIdeas() async {
    List<Idea> allIdeas = await StorageService.getIdeas();
    _sortIdeas(allIdeas);
    setState(() {
      ideas = allIdeas;
    });
  }

  void _sortIdeas(List<Idea> ideaList) {
    if (sortBy == "votes") {
      ideaList.sort((a, b) => b.votes.compareTo(a.votes));
    } else {
      ideaList.sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  void _upvote(Idea idea) async {
    if (votedIdeas.contains(idea.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You already voted for this idea!")),
      );
      return;
    }
    idea.votes += 1;
    votedIdeas.add(idea.id);
    await StorageService.updateIdeas(ideas);
    setState(() {});
  }

  void _toggleReadMore(String id) {
    setState(() {
      expandedIdeas.contains(id)
          ? expandedIdeas.remove(id)
          : expandedIdeas.add(id);
    });
  }

  void _changeSort(String value) {
    setState(() {
      sortBy = value;
      _sortIdeas(ideas);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context); // Theme ke colors yahan se lenge

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text("Idea Listing"),
        backgroundColor: colors.primaryBlue,
        foregroundColor: colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          ),
          PopupMenuButton<String>(
            onSelected: _changeSort,
            color: colors.white,
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: "votes",
                    child: Text("Sort by Votes"),
                  ),
                  const PopupMenuItem(
                    value: "rating",
                    child: Text("Sort by Rating"),
                  ),
                ],
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: ideas.length,
        itemBuilder: (context, index) {
          final idea = ideas[index];
          final isExpanded = expandedIdeas.contains(idea.id);

          return Card(
            color: colors.white,
            margin: const EdgeInsets.all(8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idea.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    idea.tagline,
                    style: TextStyle(fontSize: 14, color: colors.lightBlue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rating: ${idea.rating} | Votes: ${idea.votes}",
                    style: TextStyle(color: colors.textDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isExpanded
                        ? idea.description
                        : (idea.description.length > 50
                            ? "${idea.description.substring(0, 50)}..."
                            : idea.description),
                    style: TextStyle(color: colors.textDark),
                  ),
                  TextButton(
                    onPressed: () => _toggleReadMore(idea.id),
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primaryBlue,
                    ),
                    child: Text(isExpanded ? "Read Less" : "Read More"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _upvote(idea),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primaryBlue,
                      foregroundColor: colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.thumb_up),
                    label: const Text("Upvote"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
