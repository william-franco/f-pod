import 'package:flutter/cupertino.dart';
import 'package:f_pod/src/features/music_player/models/music_player_model.dart';

typedef _Controller = ChangeNotifier;

abstract interface class MusicPlayerController extends _Controller {
  MusicPlayerModel get musicPlayerModel;

  void initListener();
  void nextAlbum();
  void previousAlbum();
  void panHandler(DragUpdateDetails details);
}

class MusicPlayerControllerImpl extends _Controller
    implements MusicPlayerController {
  final MusicPlayerModel _musicPlayerModel = MusicPlayerModel();

  @override
  MusicPlayerModel get musicPlayerModel => _musicPlayerModel;

  @override
  void initListener() {
    _musicPlayerModel.pageCtrl.addListener(() {
      _musicPlayerModel.currentAlbum = _musicPlayerModel.pageCtrl.page!;
      notifyListeners();
    });
  }

  @override
  void nextAlbum() {
    _musicPlayerModel.pageCtrl.animateToPage(
      (_musicPlayerModel.pageCtrl.page! + 1).toInt(),
      duration: _musicPlayerModel.transitionDuration,
      curve: _musicPlayerModel.curve,
    );
    notifyListeners();
  }

  @override
  void previousAlbum() {
    _musicPlayerModel.pageCtrl.animateToPage(
      (_musicPlayerModel.pageCtrl.page! - 1).toInt(),
      duration: _musicPlayerModel.transitionDuration,
      curve: _musicPlayerModel.curve,
    );
    notifyListeners();
  }

  @override
  void panHandler(DragUpdateDetails d) {
    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Pan location on the wheel
    bool onTop = d.localPosition.dy <= 150; // 150 == radius of circle
    bool onLeftSide = d.localPosition.dx <= 150;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Absoulte change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double vert = (onRightSide && panUp) || (onLeftSide && panDown)
        ? yChange
        : yChange * -1;

    double horz = (onTop && panLeft) || (onBottom && panRight)
        ? xChange
        : xChange * -1;

    // Total computed change with velocity
    double scrollOffsetChange = (horz + vert) * (d.delta.distance * 0.2);

    // Move the page view scroller
    _musicPlayerModel.pageCtrl.jumpTo(
      _musicPlayerModel.pageCtrl.offset + scrollOffsetChange,
    );
    notifyListeners();
  }
}
