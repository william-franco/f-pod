import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_pod/src/features/music_player/models/music_player_model.dart';
import 'package:mockito/mockito.dart';
import 'music_player_controller.mocks.mocks.dart';

void main() {
  late MockMusicPlayerController controller;

  setUp(() {
    controller = MockMusicPlayerController();
  });

  test('Deve retornar um MusicPlayerModel ao acessar musicPlayerModel', () {
    final model = MusicPlayerModel();
    when(controller.musicPlayerModel).thenReturn(model);

    expect(controller.musicPlayerModel, isA<MusicPlayerModel>());
    verify(controller.musicPlayerModel).called(1);
  });

  test('Deve chamar o método initListener', () {
    controller.initListener();
    verify(controller.initListener()).called(1);
  });

  test('Deve chamar o método nextAlbum', () {
    controller.nextAlbum();
    verify(controller.nextAlbum()).called(1);
  });

  test('Deve chamar o método previousAlbum', () {
    controller.previousAlbum();
    verify(controller.previousAlbum()).called(1);
  });

  test('Deve chamar o método panHandler com detalhes de arraste', () {
    final details = DragUpdateDetails(
      globalPosition: Offset.zero,
      delta: Offset(1.0, 0.0),
    );

    controller.panHandler(details);
    verify(controller.panHandler(details)).called(1);
  });
}
