import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onScroll});
  final Function(bool) onScroll;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String formatDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  bool isNavBarVisible = true;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
