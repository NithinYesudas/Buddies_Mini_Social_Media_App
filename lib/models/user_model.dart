class User {
  final String userId, name, emailId, imageUrl, bio;
  final List<String> following, followers;
  final int postCount;

  User({
    required this.userId,
    required this.name,
    required this.emailId,
    required this.bio,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.postCount
  });
}
