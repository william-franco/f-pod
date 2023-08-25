// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:fpod/src/common_widgets/common_music_menu_button.dart';
import 'package:fpod/src/common_widgets/common_music_play_button.dart';
import 'package:fpod/src/common_widgets/common_next_song_button.dart';
import 'package:fpod/src/common_widgets/common_previous_song_button.dart';
import 'package:fpod/src/constants/constants.dart';
import 'package:fpod/src/features/music_player/view_models/music_player_view_model.dart';
import 'package:fpod/src/features/music_player/widgets/album_card_widget.dart';

class MusicPlayerView extends StatefulWidget {
  const MusicPlayerView({super.key});

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      context.read<MusicPlayerViewModel>().initListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MusicPlayerViewModel>().value;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey,
      child: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CupertinoColors.black,
                ),
                child: PageView.builder(
                  controller: viewModel.pageCtrl,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return AlbumCardWidget(
                      imageIndex: index,
                      relativePosition: index - viewModel.currentAlbum,
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onPanUpdate: (details) {
                      context.read<MusicPlayerViewModel>().panHandler(details);
                    },
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                      child: Stack(
                        children: [
                          CommonMusicMenuButton(
                            onPressed: () {},
                          ),
                          CommonNextSongButton(
                            onPressed: () {
                              context.read<MusicPlayerViewModel>().nextAlbum();
                            },
                          ),
                          CommonPreviousSongButton(
                            onPressed: () {
                              context
                                  .read<MusicPlayerViewModel>()
                                  .previousAlbum();
                            },
                          ),
                          CommonMusicPlayButton(
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
