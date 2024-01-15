import 'package:eventmobile/logging.dart';
import 'package:eventmobile/models/comment_model.dart';
import 'package:eventmobile/screens/home/provider/comment_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen(this.eventId, {super.key});
  final int eventId;
  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    ref.read(signalRStateNotifier.notifier).startConnection(widget.eventId);
    var todo = ref.read(signalRStateNotifier);
    Log.i(todo.toString());
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }


  void onsubmitted() {
  
    _commentController.clear();
    FocusScope.of(context).unfocus();
    
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: StreamBuilder<List<dynamic>>(
              stream: ref.read(signalRStateNotifier.notifier).stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  final comments = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: CommentCard(
                          comments: comments[index],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, keyboardSpace + 16),
            child: TextFormField(
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
            ),
          ),
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

  String formatDateTimeDifference(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inDays > 365) {
    int years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays > 30) {
    int months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else {
    return 'just now';
  }
}



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
                            comments.authorUsername,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatDateTimeDifference(comments.date),
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


