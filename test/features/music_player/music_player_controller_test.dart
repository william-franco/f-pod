import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_pod/src/features/music_player/models/music_player_model.dart';
import 'package:mockito/mockito.dart';

import 'music_player_view_model.mocks.mocks.dart';

void main() {
  late MockMusicPlayerViewModel viewModel;

  setUp(() {
    viewModel = MockMusicPlayerViewModel();
  });

  test('Deve retornar um MusicPlayerModel ao acessar musicPlayerModel', () {
    final model = MusicPlayerModel();
    when(viewModel.musicPlayerModel).thenReturn(model);

    expect(viewModel.musicPlayerModel, isA<MusicPlayerModel>());
    verify(viewModel.musicPlayerModel).called(1);
  });

  test('Deve chamar o método initListener', () {
    viewModel.initListener();
    verify(viewModel.initListener()).called(1);
  });

  test('Deve chamar o método nextAlbum', () {
    viewModel.nextAlbum();
    verify(viewModel.nextAlbum()).called(1);
  });

  test('Deve chamar o método previousAlbum', () {
    viewModel.previousAlbum();
    verify(viewModel.previousAlbum()).called(1);
  });

  test('Deve chamar o método panHandler com detalhes de arraste', () {
    final details = DragUpdateDetails(
      globalPosition: Offset.zero,
      delta: Offset(1.0, 0.0),
    );

    viewModel.panHandler(details);
    verify(viewModel.panHandler(details)).called(1);
  });
}
