import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
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
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    Comment(
      avatar: 'B',
      name: 'Jane Smith',
      body: 'Nice work!',
      time: '2 hours ago',
    ),
    // Add more comments as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: SingleChildScrollView(
                    child: CommentCard(
                      comments: comments[index],
                    ),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                suffixIcon: const Icon(Icons.send),
                hintText: 'Write a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          )
        ],
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
                              fontWeight: FontWeight.w600,
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
                          fontWeight: FontWeight.w600,
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
