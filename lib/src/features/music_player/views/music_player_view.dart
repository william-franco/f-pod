import 'package:flutter/cupertino.dart';
import 'package:f_pod/src/common/state_management/state_management.dart';
import 'package:f_pod/src/common/widgets/music_menu_button_widget.dart';
import 'package:f_pod/src/common/widgets/music_play_button_widget.dart';
import 'package:f_pod/src/common/widgets/next_song_button_widget.dart';
import 'package:f_pod/src/common/widgets/previous_song_button_widget.dart';
import 'package:f_pod/src/common/constants/constants.dart';
import 'package:f_pod/src/features/music_player/models/music_player_model.dart';
import 'package:f_pod/src/features/music_player/view_models/music_player_view_model.dart';
import 'package:f_pod/src/features/music_player/widgets/album_card_widget.dart';

class MusicPlayerView extends StatelessWidget {
  final MusicPlayerViewModel musicPlayerViewModel;

  const MusicPlayerView({super.key, required this.musicPlayerViewModel});

  @override
  Widget build(BuildContext context) {
    return StateBuilderWidget<MusicPlayerViewModel, MusicPlayerModel>(
      viewModel: musicPlayerViewModel,
      builder: (context, musicPlayerModel) {
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
                      controller: musicPlayerModel.pageCtrl,
                      scrollDirection: Axis.horizontal,
                      itemCount: Constants.images.length,
                      itemBuilder: (context, index) {
                        return AlbumCardWidget(
                          imageIndex: index,
                          relativePosition:
                              index - musicPlayerModel.currentAlbum,
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
                          musicPlayerViewModel.panHandler(details);
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
                              MusicMenuButtonWidget(onPressed: () {}),
                              NextSongButtonWidget(
                                onPressed: () {
                                  musicPlayerViewModel.nextAlbum();
                                },
                              ),
                              PreviousSongButtonWidget(
                                onPressed: () {
                                  musicPlayerViewModel.previousAlbum();
                                },
                              ),
                              MusicPlayButtonWidget(onPressed: () {}),
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
      },
    );
  }
}
