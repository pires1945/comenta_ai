import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final void Function(String) submit;
  const Search({
    super.key,
    required this.submit,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(disabledBorder: InputBorder.none),
        onChanged: widget.submit,
      ),
    );
  }
}
