import 'package:flutter/cupertino.dart';

class MusicPlayerModel {
  final Cubic curve = Curves.easeIn;
  final PageController pageCtrl;
  final Duration transitionDuration = const Duration(milliseconds: 300);
  final double currentAlbum;

  MusicPlayerModel({PageController? controller, this.currentAlbum = 0.0})
    : pageCtrl = controller ?? PageController(viewportFraction: 0.6);

  MusicPlayerModel._({required this.pageCtrl, required this.currentAlbum});

  MusicPlayerModel copyWith({double? currentAlbum}) {
    return MusicPlayerModel._(
      pageCtrl: pageCtrl,
      currentAlbum: currentAlbum ?? this.currentAlbum,
    );
  }
}
