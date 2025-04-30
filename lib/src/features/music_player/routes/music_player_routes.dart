import 'package:flutter/cupertino.dart';
import 'package:fpod/src/features/music_player/views/music_player_view.dart';
import 'package:go_router/go_router.dart';

class MusicPlayerRoutes {
  static String get musicPlayer => '/music-player';

  final routes = GoRoute(
    path: musicPlayer,
    pageBuilder: (context, state) {
      return CupertinoPage(child: MusicPlayerView());
    },
  );
}
