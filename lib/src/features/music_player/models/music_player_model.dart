import 'package:flutter/cupertino.dart';

class MusicPlayerModel {
  final Cubic curve = Curves.easeIn;
  final PageController pageCtrl;
  final Duration transitionDuration = const Duration(milliseconds: 300);
  double currentAlbum = 0.0;

  MusicPlayerModel({PageController? controller})
    : pageCtrl = controller ?? PageController(viewportFraction: 0.6);
}
