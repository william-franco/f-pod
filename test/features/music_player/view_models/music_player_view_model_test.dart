import 'package:f_pod/src/features/music_player/view_models/music_player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget mínimo que ataca o PageController do ViewModel ao tree do Flutter,
// permitindo que page e offset sejam acessados sem assertions.
Widget buildTestWidget(MusicPlayerViewModelImpl viewModel) {
  return MaterialApp(
    home: Scaffold(
      body: PageView.builder(
        controller: viewModel.state.pageCtrl,
        itemCount: 10,
        itemBuilder: (_, index) => Center(child: Text('Album $index')),
      ),
    ),
  );
}

void main() {
  group('MusicPlayerViewModel Test', () {
    late MusicPlayerViewModelImpl viewModel;

    setUpAll(() {});

    setUp(() {
      viewModel = MusicPlayerViewModelImpl();
    });

    tearDown(() {
      viewModel.dispose();
    });

    // -------------------------------------------------------------------------
    // Initial state
    // -------------------------------------------------------------------------

    group('initial state', () {
      test('should start with currentAlbum=0.0', () {
        expect(viewModel.state.currentAlbum, 0.0);
      });

      test('should expose a non-null PageController', () {
        expect(viewModel.state.pageCtrl, isNotNull);
      });

      test('should have transitionDuration of 300ms', () {
        expect(
          viewModel.state.transitionDuration,
          const Duration(milliseconds: 300),
        );
      });

      test('should have curve set to Curves.easeIn', () {
        expect(viewModel.state.curve, Curves.easeIn);
      });
    });

    // -------------------------------------------------------------------------
    // nextAlbum
    // -------------------------------------------------------------------------

    group('nextAlbum', () {
      testWidgets('should navigate to page 1 '
          'when nextAlbum is called from page 0', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        viewModel.nextAlbum();
        await tester.pumpAndSettle();

        expect(viewModel.state.pageCtrl.page!.round(), 1);
      });

      testWidgets('should update currentAlbum state '
          'after nextAlbum animates to the next page', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        viewModel.nextAlbum();
        await tester.pumpAndSettle();

        expect(viewModel.state.currentAlbum.round(), 1);
      });
    });

    // -------------------------------------------------------------------------
    // previousAlbum
    // -------------------------------------------------------------------------

    group('previousAlbum', () {
      testWidgets('should navigate back to page 0 '
          'when previousAlbum is called from page 1', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        // Avança para a página 1 primeiro
        viewModel.nextAlbum();
        await tester.pumpAndSettle();
        expect(viewModel.state.pageCtrl.page!.round(), 1);

        // Volta para a página 0
        viewModel.previousAlbum();
        await tester.pumpAndSettle();

        expect(viewModel.state.pageCtrl.page!.round(), 0);
      });

      testWidgets('should update currentAlbum state '
          'after previousAlbum animates to the previous page', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        viewModel.nextAlbum();
        await tester.pumpAndSettle();

        viewModel.previousAlbum();
        await tester.pumpAndSettle();

        expect(viewModel.state.currentAlbum.round(), 0);
      });
    });

    // -------------------------------------------------------------------------
    // panHandler
    // -------------------------------------------------------------------------

    group('panHandler', () {
      testWidgets('should move offset forward '
          'when dragging up on the right side of the wheel', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        final offsetBefore = viewModel.state.pageCtrl.offset;

        // Lado direito (dx=200 > 150), arrastar para cima (dy=-10)
        viewModel.panHandler(
          DragUpdateDetails(
            globalPosition: const Offset(200, 100),
            localPosition: const Offset(200, 100),
            delta: const Offset(0, -10),
          ),
        );
        await tester.pump();

        expect(viewModel.state.pageCtrl.offset, greaterThan(offsetBefore));
      });

      testWidgets('should move offset backward '
          'when dragging down on the right side of the wheel', (tester) async {
        // Começa em um offset não-zero para poder decrementar
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        viewModel.nextAlbum();
        await tester.pumpAndSettle();

        final offsetBefore = viewModel.state.pageCtrl.offset;

        // Lado direito (dx=200 > 150), arrastar para baixo (dy=+10)
        viewModel.panHandler(
          DragUpdateDetails(
            globalPosition: const Offset(200, 200),
            localPosition: const Offset(200, 200),
            delta: const Offset(0, 10),
          ),
        );
        await tester.pump();

        expect(viewModel.state.pageCtrl.offset, lessThan(offsetBefore));
      });

      testWidgets('should not change offset '
          'when delta is zero', (tester) async {
        await tester.pumpWidget(buildTestWidget(viewModel));
        await tester.pumpAndSettle();

        final offsetBefore = viewModel.state.pageCtrl.offset;

        viewModel.panHandler(
          DragUpdateDetails(
            globalPosition: const Offset(200, 100),
            localPosition: const Offset(200, 100),
            delta: Offset.zero,
          ),
        );
        await tester.pump();

        expect(viewModel.state.pageCtrl.offset, offsetBefore);
      });
    });
  });
}
