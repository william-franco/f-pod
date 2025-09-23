import 'package:flutter/cupertino.dart';
import 'package:f_pod/src/common/widgets/music_menu_button_widget.dart';
import 'package:f_pod/src/common/widgets/music_play_button_widget.dart';
import 'package:f_pod/src/common/widgets/next_song_button_widget.dart';
import 'package:f_pod/src/common/widgets/previous_song_button_widget.dart';
import 'package:f_pod/src/common/constants/constants.dart';
import 'package:f_pod/src/features/music_player/controllers/music_player_controller.dart';
import 'package:f_pod/src/features/music_player/widgets/album_card_widget.dart';

class MusicPlayerView extends StatefulWidget {
  final MusicPlayerController musicPlayerController;

  const MusicPlayerView({super.key, required this.musicPlayerController});

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  late final MusicPlayerController musicPlayerController;

  @override
  void initState() {
    super.initState();
    musicPlayerController = widget.musicPlayerController;
    musicPlayerController.initListener();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: musicPlayerController.musicPlayerModel.pageCtrl,
                  scrollDirection: Axis.horizontal,
                  itemCount: Constants.images.length,
                  itemBuilder: (context, index) {
                    return AlbumCardWidget(
                      imageIndex: index,
                      relativePosition:
                          index -
                          musicPlayerController.musicPlayerModel.currentAlbum,
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
                      musicPlayerController.panHandler(details);
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
                              musicPlayerController.nextAlbum();
                            },
                          ),
                          PreviousSongButtonWidget(
                            onPressed: () {
                              musicPlayerController.previousAlbum();
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
  }
}
