import 'package:fpod/src/features/music_player/routes/music_player_routes.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static String get home => MusicPlayerRoutes.musicPlayer;

  final routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [MusicPlayerRoutes().routes],
  );
}
