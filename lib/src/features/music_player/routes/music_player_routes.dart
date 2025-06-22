import 'package:flutter/cupertino.dart';
import 'package:fpod/src/common/dependency_injectors/dependency_injector.dart';
import 'package:fpod/src/features/music_player/controllers/music_player_controller.dart';
import 'package:fpod/src/features/music_player/views/music_player_view.dart';
import 'package:go_router/go_router.dart';

class MusicPlayerRoutes {
  static String get musicPlayer => '/music-player';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: musicPlayer,
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: MusicPlayerView(
            musicPlayerController: locator<MusicPlayerController>(),
          ),
        );
      },
    ),
  ];
}
