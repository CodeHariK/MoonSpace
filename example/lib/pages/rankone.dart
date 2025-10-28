import 'dart:convert';

import 'package:example/pages/travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rankone.g.dart';

class Game {
  final String imageSrc;
  final String name;
  final String date;
  final String platform;

  Game({
    required this.imageSrc,
    required this.name,
    required this.date,
    required this.platform,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      imageSrc: json['image_src'],
      name: json['name'],
      date: json['date'],
      platform: json['platform'],
    );
  }
}

@Riverpod(keepAlive: true)
FutureOr<List<Game>> games(Ref ref) async {
  final String response = await rootBundle.loadString('assets/rankone.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Game.fromJson(json)).toList();
}

class GamesApp extends ConsumerWidget {
  const GamesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsyncValue = ref.watch(gamesProvider);

    return gamesAsyncValue.when(
      data: (games) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: .75,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return Stack(
                      children: [
                        CustomCacheImage(
                          imageUrl: game.imageSrc,
                          borderRadius: 8,
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Colors.transparent,
                          //     Colors.black.withAlpha(100),
                          //     Colors.black.withAlpha(250),
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                        ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       game.name,
                        //       style: GoogleFonts.pixelifySans(
                        //         textStyle: context.h4,
                        //       ),
                        //       maxLines: 2,
                        //     ),
                        //     Text(game.date, style: context.ls),
                        //   ],
                        // ),
                      ],
                    )
                    .animate()
                    .scale(begin: Offset(0.9, 0.9), end: Offset(1, 1))
                    .fadeIn(begin: .5);
              },
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
