import 'package:fpod/src/features/music_player/routes/music_player_routes.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static String get home => MusicPlayerRoutes.musicPlayer;

  GoRouter get routes => _routes;

  final GoRouter _routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [...MusicPlayerRoutes().routes],
  );
}
