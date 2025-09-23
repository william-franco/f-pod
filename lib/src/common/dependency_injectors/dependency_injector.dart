import 'package:get_it/get_it.dart';
import 'package:f_pod/src/features/music_player/controllers/music_player_controller.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startFeatureMusicPlayer();
}

void _startFeatureMusicPlayer() {
  locator.registerCachedFactory<MusicPlayerController>(
    () => MusicPlayerControllerImpl(),
  );
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<MusicPlayerController>();
  _startFeatureMusicPlayer();
}
