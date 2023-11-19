// Flutter imports:
import 'package:flutter/cupertino.dart';

class MusicPlayerModel {
  final Cubic curve = Curves.easeIn;
  final PageController pageCtrl = PageController(viewportFraction: 0.6);
  final Duration transitionDuration = const Duration(milliseconds: 300);
  double currentAlbum = 0.0;
}
