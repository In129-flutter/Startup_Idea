import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/idea_model.dart';

class StorageService {
  static const String _ideasKey = 'ideas';

  // Save Idea
  static Future<void> saveIdea(Idea idea) async {
    final prefs = await SharedPreferences.getInstance();
    List<Idea> ideas = await getIdeas();
    ideas.add(idea);
    String jsonData = jsonEncode(ideas.map((e) => e.toMap()).toList());
    await prefs.setString(_ideasKey, jsonData);
  }

  // Get All Ideas
  static Future<List<Idea>> getIdeas() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_ideasKey);
    if (data == null) return [];
    List list = jsonDecode(data);
    return list.map((e) => Idea.fromMap(e)).toList();
  }

  // Update Ideas
  static Future<void> updateIdeas(List<Idea> ideas) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(ideas.map((e) => e.toMap()).toList());
    await prefs.setString(_ideasKey, jsonData);
  }
}
