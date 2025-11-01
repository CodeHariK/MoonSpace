import 'package:flutter/material.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

class NavView extends StatelessWidget {
  const NavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(height: 560, child: NavigationDrawerSection()),

            SizedBox(height: 320, child: IntrinsicWidth(child: NavigationRailSection())),
          ],
        ),
      ],
    );
  }
}

class NavigationDrawerSection extends StatefulWidget {
  const NavigationDrawerSection({super.key});

  @override
  State<NavigationDrawerSection> createState() => _NavigationDrawerSectionState();
}

class _NavigationDrawerSectionState extends State<NavigationDrawerSection> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navDrawerIndex = selectedIndex;
        });
      },
      selectedIndex: navDrawerIndex,
      children: <Widget>[
        DrawerHeader(child: Text("Header")),

        ExpansionPanelList(
          materialGapSize: 0,
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.all(0),
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: true,
              headerBuilder: (context, isExpanded) =>
                  ListTile(title: Text('Home', style: context.h6.w5)),

              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...destinations.asMap().entries.map((destination) {
                      return ListTile(
                        leading: destination.value.icon,
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
                            navDrawerIndex = destination.key;
                          });
                        },
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: true,
              headerBuilder: (context, isExpanded) =>
                  ListTile(title: Text('Home', style: context.h6.w5)),
              body: Column(
                children: destinations.asMap().entries.map((destination) {
                  return ListTile(
                    leading: destination.value.icon,
                    title: Text(destination.value.label),
                    selected: destination.key == navDrawerIndex,
                    onTap: () {
                      setState(() {
                        navDrawerIndex = destination.key;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        ...destinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Labels', style: Theme.of(context).textTheme.titleSmall),
        ),
        ...destinations.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

class NavigationRailSection extends StatefulWidget {
  const NavigationRailSection({super.key});

  @override
  State<NavigationRailSection> createState() => _NavigationRailSectionState();
}

class _NavigationRailSectionState extends State<NavigationRailSection> {
  int navRailIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navRailIndex = selectedIndex;
        });
      },
      elevation: 4,
      leading: FloatingActionButton(
        heroTag: "railnav",
        child: const Icon(Icons.create),
        onPressed: () {},
      ),
      groupAlignment: 0.0,
      selectedIndex: navRailIndex,
      labelType: NavigationRailLabelType.selected,
      destinations: <NavigationRailDestination>[
        ...destinations.map((destination) {
          return NavigationRailDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
      ],
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination('Dashboard', Icon(Icons.inbox_outlined), Icon(Icons.inbox)),
  ExampleDestination('Report Overview', Icon(Icons.send_outlined), Icon(Icons.send)),
  ExampleDestination('Insights', Icon(Icons.favorite_outline), Icon(Icons.favorite)),
  ExampleDestination(
    'Manage Task',
    Icon(Icons.legend_toggle_sharp),
    Icon(Icons.legend_toggle_sharp),
  ),
  ExampleDestination('Settings', Icon(Icons.settings), Icon(Icons.settings)),
];
