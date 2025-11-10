class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final int followers;
  final int following;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.followers,
    required this.following,
  });
}