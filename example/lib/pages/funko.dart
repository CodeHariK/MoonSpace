import 'dart:convert';

import 'package:example/pages/travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'funko.g.dart';

class Funko {
  final String title;
  final String price;
  final String imageSrc;

  Funko({required this.title, required this.price, required this.imageSrc});

  factory Funko.fromJson(Map<String, dynamic> json) {
    return Funko(
      title: json['title'],
      price: json['price']
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim(), // Clean up the price string
      imageSrc: json['image_src'],
    );
  }
}

@Riverpod(keepAlive: true)
FutureOr<List<Funko>> funko(Ref ref) async {
  final String response = await rootBundle.loadString('assets/funko.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Funko.fromJson(json)).toList();
}

class FunkoApp extends ConsumerWidget {
  const FunkoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFunko = ref.watch(funkoProvider);

    return asyncFunko.when(
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
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(100),
                              Colors.black.withAlpha(250),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              game.title,
                              style: GoogleFonts.pixelifySans(
                                textStyle: context.h4,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
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
