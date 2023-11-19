// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:fpod/src/features/music_player/view_models/music_player_view_model.dart';

void main() {
  group('MusicPlayerViewModelImpl', () {
    late MusicPlayerViewModel viewModel;

    setUp(() {
      viewModel = MusicPlayerViewModelImpl();
    });

    test('initListener should update currentAlbum when page changes', () {
      viewModel.initListener();
      viewModel.value.pageCtrl.jumpTo(1.0);

      expect(viewModel.value.currentAlbum, equals(1.0));
    });

    test('nextAlbum should animate to the next page and notify listeners', () {
      viewModel.nextAlbum();

      expect(viewModel.value.pageCtrl.page, equals(1.0));
      expect(viewModel.hasListeners, isTrue);
    });

    test(
        'previousAlbum should animate to the previous page and notify listeners',
        () {
      viewModel.previousAlbum();

      expect(viewModel.value.pageCtrl.page, equals(-1.0));
      expect(viewModel.hasListeners, isTrue);
    });

    test('panHandler should update pageCtrl and notify listeners', () {
      final dragUpdateDetails = DragUpdateDetails(
        primaryDelta: 10.0,
        globalPosition: const Offset(0.0, 0.0),
        localPosition: const Offset(10.0, 10.0),
        delta: const Offset(5.0, 5.0),
      );

      viewModel.panHandler(dragUpdateDetails);

      expect(viewModel.value.pageCtrl.offset, equals(10.0));
      expect(viewModel.hasListeners, isTrue);
    });
  });
}
