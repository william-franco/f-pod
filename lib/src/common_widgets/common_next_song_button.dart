// Flutter imports:
import 'package:flutter/cupertino.dart';

class CommonNextSongButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CommonNextSongButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 4.0),
      child: CupertinoButton(
        onPressed: onPressed,
        child: const Icon(
          CupertinoIcons.forward_end_alt_fill,
          color: CupertinoColors.white,
          size: 40,
        ),
      ),
    );
  }
}
