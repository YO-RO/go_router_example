import 'package:flutter/material.dart';

import 'error_page.dart';

class TweetPage extends StatelessWidget {
  const TweetPage({Key? key, required this.tweetId}) : super(key: key);

  final String tweetId;

  @override
  Widget build(BuildContext context) {
    if (tweetId == '2') {
      return const ErrorPage();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('the tweet id is $tweetId'),
      ),
    );
  }
}
