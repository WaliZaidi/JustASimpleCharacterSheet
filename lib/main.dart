import 'package:dnd_app_v2/utils/routes/routes.dart';
import 'package:dnd_app_v2/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiService.instance.initialiseAPI();

  runApp(const ProviderScope(child: JustASimpleCharacterSheet()));
}

class JustASimpleCharacterSheet extends ConsumerWidget {
  const JustASimpleCharacterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.read(routerConfiuration);

    return MaterialApp.router(
      title: 'JustASimpleCharacterSheet',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return _applyResponsiveConstraints(context, child);
      },
    );
  }

  Widget _applyResponsiveConstraints(BuildContext context, Widget? child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: child,
            ),
          );
        } else {
          return child!;
        }
      },
    );
  }
}
