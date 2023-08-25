// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:fpod/src/features/music_player/view_models/music_player_view_model.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ViewModels
        ChangeNotifierProvider<MusicPlayerViewModel>(
          create: (context) => MusicPlayerViewModelImpl(),
        ),
      ],
      child: child,
    );
  }
}
