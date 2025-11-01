import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarView extends StatelessWidget {
  const BarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: 1,
          onDestinationSelected: (int index) {},
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.commute), label: 'Commute'),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: 'Saved',
            ),
          ],
        ),

        BottomAppBar(
          child: Row(
            children: <Widget>[
              const IconButtonAnchorExample(),
              IconButton(tooltip: 'Search', icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(tooltip: 'Favorite', icon: const Icon(Icons.favorite), onPressed: () {}),
            ],
          ),
        ),

        BottomNavigationBar(
          showUnselectedLabels: true,
          onTap: (value) {},
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Review'),
          ],
        ),

        DefaultTabController(
          length: 3,
          child: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.videocam_outlined),
                text: 'Video',
                iconMargin: EdgeInsets.only(bottom: 0.0),
              ),
              Tab(
                icon: Icon(Icons.photo_outlined),
                text: 'Photos',
                iconMargin: EdgeInsets.only(bottom: 0.0),
              ),
              Tab(
                icon: Icon(Icons.audiotrack_sharp),
                text: 'Audio',
                iconMargin: EdgeInsets.only(bottom: 0.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IconButtonAnchorExample extends StatelessWidget {
  const IconButtonAnchorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        MenuItemButton(child: const Text('Menu 1'), onPressed: () {}),
        MenuItemButton(child: const Text('Menu 2'), onPressed: () {}),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.1')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.2')),
            MenuItemButton(onPressed: () {}, child: const Text('Menu 3.3')),
          ],
          child: const Text('Menu 3'),
        ),
      ],
    );
  }
}
