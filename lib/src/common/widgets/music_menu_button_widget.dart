import 'package:flutter/cupertino.dart';

class MusicMenuButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const MusicMenuButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 14.0),
      child: CupertinoButton(
        onPressed: onPressed,
        child: const Text(
          'MENU',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
