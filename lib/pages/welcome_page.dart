import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Image.network(
                      'https://abs.twimg.com/sticky/illustrations/lohp_1302x955.png',
                      height: constraints.maxHeight,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: (() => context.goNamed(PathName.login)),
                      child: const Text('go to login page'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => context.goNamed(PathName.home),
                child: const Text('home'),
              ),
              TextButton(
                onPressed: () => context.goNamed(PathName.home),
                child: const Text('home'),
              ),
              TextButton(
                onPressed: () => context.goNamed(PathName.home),
                child: const Text('home'),
              ),
              TextButton(
                onPressed: () => context.goNamed(PathName.home),
                child: const Text('home'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
