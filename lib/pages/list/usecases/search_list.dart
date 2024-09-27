import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key, required this.refreshSearch});
  final Function(String) refreshSearch;

  @override
  StateSearchList createState() => StateSearchList();
}

class StateSearchList extends State<SearchList> {
  final FocusNode _focusNode = FocusNode();
  final box = GetStorage();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        box.write('search_key', searchController.text);
        widget.refreshSearch(searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (box.hasData('search_key')) {
      searchController.text = box.read('search_key');
    }

    return Container(
        margin: EdgeInsets.only(bottom: spaceMD),
        child: TextFormField(
          focusNode: _focusNode,
          controller: searchController,
          style: TextStyle(fontSize: textLG),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(roundedSM)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(roundedSM),
            ),
            hintText: 'Search by list name or list tag...',
          ),
        ));
  }
}
