class Idea {
  String id;
  String name;
  String tagline;
  String description;
  int rating;
  int votes;

  Idea({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    required this.votes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
    };
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      id: map['id'],
      name: map['name'],
      tagline: map['tagline'],
      description: map['description'],
      rating: map['rating'],
      votes: map['votes'],
    );
  }
}
