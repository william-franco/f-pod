import 'package:flutter/cupertino.dart';

class MusicPlayButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const MusicPlayButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 4.0),
      child: CupertinoButton(
        onPressed: onPressed,
        child: const Icon(
          CupertinoIcons.playpause_fill,
          color: CupertinoColors.white,
          size: 40,
        ),
      ),
    );
  }
}
