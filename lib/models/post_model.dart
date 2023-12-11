
class Post {
  final int id;
  final String name;
  final String content;
  final DateTime date;
  final String? image;
  Post(
      {required this.id,
      required this.name,
      required this.content,
      required this.date,
      this.image});
}

final Post post = Post(
    content:
        "Thank you so Much For everyting.A beautiful man who's art and love will last forever.we love you forever",
    id: 1,
    name: 'PostMalone',
    date: DateTime.now(),
    image:
        'https://media.npr.org/assets/img/2023/08/01/photo-credit----_custom-9fb517adbafd7054aaf852974340533bfa50a703-s1100-c50.jpg');
