


import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventmobile/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class PostBody extends StatelessWidget {
  const PostBody({super.key});
  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                child: Text('P'),
              ),
              Text(
                post.name,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                formatDateTime(post.date),
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 320,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: post.image!,
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white, // Shimmer effect color
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const Row(
            children: [
              Icon(Icons.favorite),
              Text(
                '12k',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                ),
              ),
              Icon(Icons.comment),
              Text(
                '1300',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_horiz,
              )
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
