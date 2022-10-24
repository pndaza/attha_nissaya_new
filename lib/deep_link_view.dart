import 'package:flutter/material.dart';

import 'screens/home/home_page.dart';
import 'screens/nsy_list/nsy_choice.dart';

class DeepLinkView extends StatefulWidget {
  const DeepLinkView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _DeepLinkViewState createState() => _DeepLinkViewState();
}

class _DeepLinkViewState extends State<DeepLinkView> {
  String? bookId;
  String? pageNumber;

  @override
  void initState() {
    super.initState();
    bookId = parseBookId(widget.url);
    pageNumber = parsePageNumber(widget.url);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(bookId);
      debugPrint(pageNumber);
      if (bookId != null && pageNumber != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => NsyChoice(
                    paliBookID: bookId!,
                    paliBookPageNumber: int.parse(pageNumber!))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('building deep link view');
    // use home so that user can go back to home screen
    // desire page will be route after building by using of
    // WidgetsBinding.instance?.addPostFrameCallback
    return const Home();
  }

  String? parseBookId(String url) {
    
    RegExp regexId = RegExp(r'\w+_\w+_\d+(_\d+)?');
    final matchId = regexId.firstMatch(url);
    return matchId?.group(0);
  }

  String? parsePageNumber(String url) {
    RegExp regexPage = RegExp(r'\d+$');
    final matchPage = regexPage.firstMatch(url);
    return matchPage?.group(0);
  }
}
