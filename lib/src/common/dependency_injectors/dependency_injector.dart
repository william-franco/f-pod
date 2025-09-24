import 'package:get_it/get_it.dart';
import 'package:f_pod/src/features/music_player/controllers/music_player_view_model.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startFeatureMusicPlayer();
}

void _startFeatureMusicPlayer() {
  locator.registerCachedFactory<MusicPlayerViewModel>(
    () => MusicPlayerViewModelImpl(),
  );
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<MusicPlayerViewModel>();
  _startFeatureMusicPlayer();
}
