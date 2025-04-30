import 'package:flutter/cupertino.dart';

class PreviousSongButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const PreviousSongButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 4.0),
      child: CupertinoButton(
        onPressed: onPressed,
        child: const Icon(
          CupertinoIcons.backward_end_alt_fill,
          color: CupertinoColors.white,
          size: 40,
        ),
      ),
    );
  }
}
