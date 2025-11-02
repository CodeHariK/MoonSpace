import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon_debug/helper/image_save.dart';
import 'package:moon_debug/image_reference_viewer.dart';
import 'package:moon_debug/saved_screenshot_grid.dart';
import 'package:moonspace/electrify.dart';
import 'package:moonspace/provider/global_theme.dart';

import 'package:device_frame_plus/device_frame_plus.dart';

class MoonDrawerLink {
  final String label;
  final String? path;
  final Widget? child;

  MoonDrawerLink({required this.label, this.path, this.child});
}

class MoonDebugWrapper extends StatefulWidget {
  const MoonDebugWrapper({super.key, required this.child, required this.paths});

  final Widget child;
  final List<MoonDrawerLink> paths;

  @override
  State<MoonDebugWrapper> createState() => _MoonDebugWrapperState();
}

class _MoonDebugWrapperState extends State<MoonDebugWrapper> {
  bool showRefImages = false;
  bool showImages = false;

  String? selectedDeviceOption = "None";
  DeviceInfo? selectedFrame;

  int navDrawerIndex = 0;
  final Set<int> openPanel = {0};
  Widget? child;

  bool accessibility = false;

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ChoiceChip(
            onSelected: (s) {
              showRefImages = !showRefImages;
              setState(() {});
            },
            selected: showRefImages,
            label: Text("Ref"),
          ),
          SizedBox(width: 10),
          ChoiceChip(
            onSelected: (s) {
              showImages = !showImages;
              setState(() {});
            },
            selected: showImages,
            label: Text("Images"),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemePopupButton(),
              CheckboxListTile(
                selected: accessibility,
                value: accessibility,
                onChanged: (v) {
                  accessibility = !accessibility;
                  setState(() {});
                },
                title: Text("Accessibility"),
              ),
              DropdownMenu<String>(
                initialSelection: selectedDeviceOption,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "None", label: "None"),
                  DropdownMenuEntry(value: "S20", label: "S20"),
                  DropdownMenuEntry(value: "iPad", label: "iPad"),
                  DropdownMenuEntry(value: "iPhone13", label: "iPhone13"),
                ],
                onSelected: (value) {
                  if (value == null) return;
                  selectedDeviceOption = value;
                  switch (value) {
                    case "None":
                      selectedFrame = null;
                      break;
                    case "S20":
                      selectedFrame = Devices.android.samsungGalaxyS20;
                      break;
                    case "iPad":
                      selectedFrame = Devices.ios.iPad;
                      break;
                    case "iPhone13":
                      selectedFrame = Devices.ios.iPhone13;
                      break;
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        onDestinationSelected: (selectedIndex) {
          setState(() {
            navDrawerIndex = selectedIndex;
          });
        },
        selectedIndex: navDrawerIndex,
        children: <Widget>[
          ExpansionPanelList(
            materialGapSize: 0,
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.all(0),
            expansionCallback: (panelIndex, isExpanded) {
              if (openPanel.contains(panelIndex)) {
                openPanel.remove(panelIndex);
              } else {
                openPanel.add(panelIndex);
              }
              setState(() {});
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: openPanel.contains(0),
                headerBuilder: (context, isExpanded) => ListTile(title: Text('Home')),

                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      ...widget.paths.asMap().entries.map((destination) {
                        return ListTile(
                          title: Text(destination.value.label),
                          selected: destination.key == navDrawerIndex,
                          style: ListTileStyle.drawer,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          shape: destination.key != navDrawerIndex
                              ? null
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.all(Radius.circular(32)),
                                ),
                          onTap: () {
                            setState(() {
                              child = null;

                              navDrawerIndex = destination.key;
                              if (destination.value.path != null) {
                                if (Electric.navigatorContext.canPop()) {
                                  Electric.navigatorContext.pop();
                                }
                                Electric.navigatorContext.push(destination.value.path!);
                              }
                              if (destination.value.child != null) {
                                child = destination.value.child;
                              }
                            });
                          },
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: showImages
          ? const SavedScreenshotGrid()
          : Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      accessibility ? AccessibilityTools(child: _buildScreen()) : _buildScreen(),
                      FloatingActionButton(
                        heroTag: 'variable_grid',
                        onPressed: () => capturePng(_globalKey),
                        tooltip: 'Create Variable Size Grid',
                        child: const Icon(Icons.camera),
                      ),
                    ],
                  ),
                ),

                if (showRefImages) Expanded(child: ImageReferenceViewer()),
              ],
            ),
    );
  }

  Widget _buildScreen() {
    return Center(
      child: RepaintBoundary(
        key: _globalKey,
        child: selectedFrame != null
            ? DeviceFrame(
                device: selectedFrame ?? Devices.ios.iPhone13,
                screen: Stack(children: [widget.child, if (child != null) child!]),
              )
            : Stack(children: [widget.child, if (child != null) child!]),
      ),
    );
  }
}
