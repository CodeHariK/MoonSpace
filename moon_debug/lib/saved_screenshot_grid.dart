import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:moon_debug/helper/image_save.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

import 'package:path_provider/path_provider.dart';

class SavedScreenshotGrid extends StatefulWidget {
  const SavedScreenshotGrid({super.key});

  @override
  State<SavedScreenshotGrid> createState() => _SavedScreenshotGridState();
}

class _SavedScreenshotGridState extends State<SavedScreenshotGrid> {
  List<File> imageFiles = [];
  Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();

    final images =
        files
            .whereType<File>()
            .where(
              (file) =>
                  file.path.toLowerCase().endsWith('.png') ||
                  file.path.toLowerCase().endsWith('.jpg') ||
                  file.path.toLowerCase().endsWith('.jpeg'),
            )
            .toList()
          ..sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    setState(() {
      imageFiles = images;
      selectedIndexes = Set.from(List.generate(files.length, (i) => i));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cSecCon,
      body: imageFiles.isEmpty
          ? Center(child: Text('No images found.', style: context.dl.c(context.cOnSec)))
          : Stack(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: imageFiles.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndexes.contains(index);
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!selectedIndexes.contains(index)) {
                                selectedIndexes.add(index);
                              } else {
                                selectedIndexes.remove(index);
                              }
                            });
                          },
                          child: Opacity(
                            opacity: isSelected ? 1.0 : 0.3,
                            child: Image.file(imageFiles[index], fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20,
                              color: ui.Color.fromARGB(255, 255, 86, 86),
                            ),
                            onPressed: () {
                              setState(() {
                                imageFiles[index].deleteSync();
                                imageFiles.removeAt(index);
                                selectedIndexes.remove(index);

                                // Rebuild indexes
                                selectedIndexes = selectedIndexes
                                    .map((i) => i > index ? i - 1 : i)
                                    .toSet();
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Grid creation buttons
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Uniform height grid button
                      FloatingActionButton(
                        heroTag: 'uniform_grid',
                        onPressed: () async {
                          final selectedFiles = selectedIndexes.map((i) => imageFiles[i]).toList();
                          if (selectedFiles.isNotEmpty) {
                            await createUniformHeightGrid(
                              imageFiles: selectedFiles,
                              xCount: 3,
                              targetHeight: 3000,
                              xPad: 16,
                              yPad: 24,
                            );
                          }
                        },
                        tooltip: 'Create Uniform Height Grid',
                        child: const Icon(Icons.grid_on),
                      ),

                      const SizedBox(height: 12),

                      // Variable size grid button
                      FloatingActionButton(
                        heroTag: 'variable_grid',
                        onPressed: () async {
                          final selectedFiles = selectedIndexes.map((i) => imageFiles[i]).toList();
                          if (selectedFiles.isNotEmpty) {
                            await createGridImageFromFiles(selectedFiles, 3);
                          }
                        },
                        tooltip: 'Create Variable Size Grid',
                        child: const Icon(Icons.view_module),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
