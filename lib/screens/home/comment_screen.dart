import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  List<Comment> comments = [
    Comment(
      avatar: 'A',
      name: 'John Doe',
      body:
          'Great post! keeep it up indeed whfi  wjfi  wufo  wjf owfjof dghhdggd name the besry sdgydyg friend i am never going to beat that baghd bat man flash',
      time: '1 hour ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),

    // Add more comments as needed
  ];

  void onsubmitted() {
    Comment comment = Comment(
      avatar: 'z',
      name: 'Dave david',
      body: _commentController.text,
      time: '1 hour ago',
    );
    _commentController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      comments.add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: CommentCard(
                      comments: comments[index],
                    ),
                  );
                },
              ),
            ),
            TextFormField(
              controller: _commentController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    onsubmitted();
                  },
                  child: const Icon(Icons.send),
                ),
                hintText: 'Write a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onFieldSubmitted: (value) {
                onsubmitted();
              },
            )
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comments,
  });

  final Comment comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://picsum.photos/seed/468/600',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // This function will be called when the image fails to load
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: 260,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            comments.name,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            comments.time,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        comments.body,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 13,
        )
      ],
    );
  }
}

class Comment {
  final String avatar;
  final String name;
  final String body;
  final String time;

  Comment({
    required this.avatar,
    required this.name,
    required this.body,
    required this.time,
  });
}
