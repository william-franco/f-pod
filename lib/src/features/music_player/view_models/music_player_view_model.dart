// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fpod/src/features/music_player/models/music_player_model.dart';

abstract base class MusicPlayerViewModel
    extends ValueNotifier<MusicPlayerModel> {
  MusicPlayerViewModel() : super(MusicPlayerModel());

  void initListener();
  void nextAlbum();
  void previousAlbum();
  void panHandler(DragUpdateDetails d);
}

base class MusicPlayerViewModelImpl extends ValueNotifier<MusicPlayerModel>
    implements MusicPlayerViewModel {
  MusicPlayerViewModelImpl() : super(MusicPlayerModel());

  @override
  void initListener() {
    value.pageCtrl.addListener(() {
      value.currentAlbum = value.pageCtrl.page!;
      notifyListeners();
    });
  }

  @override
  void nextAlbum() {
    value.pageCtrl.animateToPage(
      (value.pageCtrl.page! + 1).toInt(),
      duration: value.transitionDuration,
      curve: value.curve,
    );
    notifyListeners();
  }

  @override
  void previousAlbum() {
    value.pageCtrl.animateToPage(
      (value.pageCtrl.page! - 1).toInt(),
      duration: value.transitionDuration,
      curve: value.curve,
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

    double horz =
        (onTop && panLeft) || (onBottom && panRight) ? xChange : xChange * -1;

    // Total computed change with velocity
    double scrollOffsetChange = (horz + vert) * (d.delta.distance * 0.2);

    // Move the page view scroller
    value.pageCtrl.jumpTo(value.pageCtrl.offset + scrollOffsetChange);
    notifyListeners();
  }
}
