import 'package:dnd_app_v2/utils/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavDrawer extends StatefulWidget {
  const AppNavDrawer({super.key});

  @override
  State<AppNavDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<AppNavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Character Sections',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: const Text('Combat & Skills'),
            onTap: () =>
                context.pushReplacement(RouteNames.instance.combatInfo),
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Features'),
            onTap: () => context.pushReplacement(RouteNames.instance.features),
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('Biography'),
            onTap: () => context.pushReplacement(RouteNames.instance.biography),
          ),
        ],
      ),
    );
  }
}
