class Post {
  final String userId, id, imageUrl, caption;
  final List<String> likes;
  final List<Comment> comments;
  final DateTime postTime;

  Post(
      {required this.userId,
      required this.id,
      required this.imageUrl,
      required this.caption,
      required this.likes,
      required this.postTime,
      required this.comments});
}

class Comment {
  final String userId, comment;

  Comment({required this.userId, required this.comment});
}
