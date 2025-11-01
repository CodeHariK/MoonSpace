import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:moonspace/form/sherlock.dart';

class ImageReferenceViewer extends StatefulWidget {
  const ImageReferenceViewer({super.key, this.deviceFrame});

  final DeviceInfo? deviceFrame;

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
            frameBuilder: widget.deviceFrame == null
                ? null
                : (context, child, fram, wasSynchronouslyLoaded) =>
                      DeviceFrame(device: widget.deviceFrame!, screen: child),
            errorBuilder: (context, error, stackTrace) {
              return Placeholder();
            },
          ),
      ],
    );
  }
}
