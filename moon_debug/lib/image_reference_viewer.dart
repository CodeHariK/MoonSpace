import 'package:flutter/material.dart';
import 'package:moonspace/form/sherlock.dart';

class ImageReferenceViewer extends StatefulWidget {
  const ImageReferenceViewer({super.key});

  @override
  State<ImageReferenceViewer> createState() => _ImageReferenceViewerState();
}

class _ImageReferenceViewerState extends State<ImageReferenceViewer> {
  String? selectedImage;
  Set<String> images = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Sherlock(
          onFetch: (query) async {
            return images.toList();
          },
          onSubmit: (query) async {
            images.add(query);
            return images.toList();
          },
          builder: (data, controller) {
            return ListView(
              shrinkWrap: true,
              children: images
                  .toList()
                  .map(
                    (e) => ListTile(
                      onTap: () {
                        selectedImage = e;
                        setState(() {});
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          images.remove(e);
                          data = images.toList();
                          controller.closeView(null);
                          controller.openView();
                        },
                      ),
                      title: Text(e, maxLines: 1),
                    ),
                  )
                  .toList(),
            );
          },
          bar: true,
        ),
        if (selectedImage != null)
          Image.network(
            selectedImage!,
            errorBuilder: (context, error, stackTrace) {
              return Placeholder();
            },
          ),
      ],
    );
  }
}
