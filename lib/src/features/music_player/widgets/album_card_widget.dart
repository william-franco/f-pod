import 'package:flutter/cupertino.dart';
import 'package:fpod/src/common/constants/constants.dart';

class AlbumCardWidget extends StatelessWidget {
  final int imageIndex;
  final double relativePosition;

  const AlbumCardWidget({
    super.key,
    required this.imageIndex,
    required this.relativePosition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Transform(
        transform:
            Matrix4.identity()
              ..setEntry(3, 2, 0.003) // add perspective
              ..scale((1 - relativePosition.abs()).clamp(0.2, 0.6) + 0.4)
              ..rotateY(relativePosition),
        // ..rotateZ(relativePosition),
        alignment:
            relativePosition >= 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CupertinoColors.activeBlue,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(Constants.images[imageIndex]),
            ),
          ),
        ),
      ),
    );
  }
}
