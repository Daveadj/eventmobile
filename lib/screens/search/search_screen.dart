import 'package:eventmobile/models/event_models.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // try {
    //   var matchingEvents = events.where(
    //     (element) => element.description.toLowerCase() == query.toLowerCase(),
    //   );

    //   if (matchingEvents.isNotEmpty) {
    //     var event = matchingEvents.first;

    //     return Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    //       child: GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             MaterialPageRoute(
    //               builder: (ctx) => EventDetails(
    //                 event: event,
    //               ),
    //             ),
    //           );
    //         },
    //         child: LargeEventContainer(
    //           event: event,
    //         ),
    //       ),
    //     );
    //   } else {
    //     return Center(
    //       child: Text('No matching events found for "$query"'),
    //     );
    //   }
    // } catch (e) {
    //   return Center(
    //     child: Text('Error: ${e.toString()}'),
    //   );
    // }
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}

var event =
    events.where((element) => element.description == 'what').firstOrNull;
