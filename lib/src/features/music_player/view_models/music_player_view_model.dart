import 'package:flutter/cupertino.dart';
import 'package:f_pod/src/common/state_management/state_management.dart';
import 'package:f_pod/src/features/music_player/models/music_player_model.dart';

typedef _ViewModel = StateManagement<MusicPlayerModel>;

abstract class MusicPlayerViewModel extends _ViewModel {
  void nextAlbum();
  void previousAlbum();
  void panHandler(DragUpdateDetails details);
}

class MusicPlayerViewModelImpl extends _ViewModel
    implements MusicPlayerViewModel {
  MusicPlayerViewModelImpl() {
    _initListener();
  }

  @override
  MusicPlayerModel build() => MusicPlayerModel();

  void _initListener() {
    state.pageCtrl.addListener(() {
      emitState(state.copyWith(currentAlbum: state.pageCtrl.page!));
    });
  }

  @override
  void nextAlbum() {
    state.pageCtrl.animateToPage(
      (state.pageCtrl.page! + 1).toInt(),
      duration: state.transitionDuration,
      curve: state.curve,
    );
  }

  @override
  void previousAlbum() {
    state.pageCtrl.animateToPage(
      (state.pageCtrl.page! - 1).toInt(),
      duration: state.transitionDuration,
      curve: state.curve,
    );
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

    /// Absolute change on axis
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

    // Move the page view scroller (page listener handles the state update)
    state.pageCtrl.jumpTo(state.pageCtrl.offset + scrollOffsetChange);
  }
}
