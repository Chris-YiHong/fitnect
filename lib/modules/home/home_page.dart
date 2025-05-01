import 'package:fitnect/core/theme/extensions/theme_extension.dart';
import 'package:fitnect/core/theme/providers/theme_provider.dart';
import 'package:fitnect/modules/notifications/api/local_notifier.dart';
import 'package:fitnect/modules/notifications/providers/models/notification.dart'
    as apparence_kit; // this conflicts with material notification ()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// this homepage is for demo purpose only
/// You can delete it and start from scratch
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can fetch the user state like this
    // final userState = ref.watch(userStateNotifierProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: ListView(
          children: [
            Text("Home page", style: context.textTheme.headlineLarge),
            Text(
              'Welcome on the FitNect demo',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.onBackground,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),

            // Theme style demo
            const ThemeStyleShowcase(),
            const SizedBox(height: 16),

            HomeCard(
              title: "Paywall",
              description: "Show the paywall page",
              onTap: () => context.push('/premium'),
              backgroundColor: context.colors.primary,
              textColor: context.colors.onPrimary,
            ),
            const SizedBox(height: 8),
            HomeCard(
              title: "Notification test",
              description:
                  "Push a local test notification (won't be added into your notifications list)",
              onTap: () {
                // this is only for showing you how to show notifcations locally manually
                // to create a push notification from server -> add a notification in the database.
                // It will be pushed to the user devices automatically
                // 🤩 the notifications pushed by the server are automatically shown you don't have to do anything
                final settings = ref.read(notificationsSettingsProvider);
                final localNotifier = ref.read(localNotifierProvider);
                final notif = apparence_kit.Notification.withData(
                  id: 'fake-id',
                  title: 'Notification test',
                  body:
                      "Push a local test notification (won't be added into your notifications list)",
                  createdAt: DateTime.now(),
                  notifier: localNotifier,
                  notifierSettings: settings,
                );
                notif.show();
              },
            ),
            const SizedBox(height: 8),

            HomeCard(
              title: "Toggle theme mode",
              description: "Switch between light and dark mode",
              onTap: () {
                ThemeProvider.of(context).toggle();
              },
              backgroundColor: context.colors.accent,
              textColor: context.colors.onPrimary,
            ),
            const SizedBox(height: 8),

            HomeCard(
              title: "Sign Up OnBoarding",
              description: "Sign Up On Boarding",
              onTap: () {
                context.goNamed(
                  'signupOnboarding',
                  pathParameters: {'step': 'name'},
                );
              },
              backgroundColor: context.colors.accent,
              textColor: context.colors.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Theme style showcase component
class ThemeStyleShowcase extends StatelessWidget {
  const ThemeStyleShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DESIGN STYLE",
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Typography showcase
            _buildSectionTitle(context, "Typography"),
            const SizedBox(height: 16),
            _buildTypographyItem(
              context,
              "Heading 1",
              context.kitTheme.defaultTextTheme.heading1,
            ),
            _buildTypographyItem(
              context,
              "Heading 2",
              context.kitTheme.defaultTextTheme.heading2,
            ),
            _buildTypographyItem(
              context,
              "Heading 3",
              context.kitTheme.defaultTextTheme.heading3,
            ),
            _buildTypographyItem(
              context,
              "Heading 4",
              context.kitTheme.defaultTextTheme.heading4,
            ),
            _buildTypographyItem(
              context,
              "Heading 5",
              context.kitTheme.defaultTextTheme.heading5,
            ),
            _buildTypographyItem(
              context,
              "Body 1",
              context.kitTheme.defaultTextTheme.body1,
            ),
            _buildTypographyItem(
              context,
              "Body 2",
              context.kitTheme.defaultTextTheme.body2,
            ),
            _buildTypographyItem(
              context,
              "Subtext",
              context.kitTheme.defaultTextTheme.subtext,
            ),

            const SizedBox(height: 24),

            // Colors showcase
            _buildSectionTitle(context, "Colors"),
            const SizedBox(height: 16),
            _buildColorsGrid(context),

            const SizedBox(height: 24),

            // Button showcase
            _buildSectionTitle(context, "Button / Link"),
            const SizedBox(height: 16),
            _buildButtonsShowcase(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.grey1, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: context.textTheme.titleLarge),
      ),
    );
  }

  Widget _buildTypographyItem(
    BuildContext context,
    String name,
    TextStyle style,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(name, style: context.textTheme.bodyMedium),
          ),
          Expanded(
            child: Text(
              "Aa",
              style: style.copyWith(color: context.colors.onBackground),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorsGrid(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColorRow(context, "Primary", colors.primary),
        _buildColorRow(context, "Accent", colors.accent),
        _buildColorRow(context, "Secondary", colors.secondary),
        _buildColorRow(context, "Neutral", colors.neutral),
        _buildColorRow(context, "Grey", colors.neutralGrey),
        _buildColorRow(context, "Error", colors.error),
      ],
    );
  }

  Widget _buildColorRow(BuildContext context, String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(name, style: context.textTheme.bodyMedium),
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(_colorToHex(color), style: context.textTheme.bodySmall),
        ],
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  Widget _buildButtonsShowcase(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildButtonItem(
          context,
          "Button-Mainpage",
          ElevatedButton(onPressed: () {}, child: const Text("Button")),
        ),
        const SizedBox(height: 16),
        _buildButtonItem(
          context,
          "Button-Subpage",
          OutlinedButton(onPressed: () {}, child: const Text("Button")),
        ),
        const SizedBox(height: 16),
        _buildButtonItem(
          context,
          "Hyperlink",
          TextButton(onPressed: () {}, child: const Text("Hyperlink")),
        ),
      ],
    );
  }

  Widget _buildButtonItem(BuildContext context, String name, Widget button) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(name, style: context.textTheme.bodyMedium),
        ),
        Expanded(child: button),
      ],
    );
  }
}

/// Here is just a simple content card
class HomeCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String description;
  final Color? textColor;
  final Color? backgroundColor;

  const HomeCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        HapticFeedback.mediumImpact();
        onTap.call();
      },
      child: Card(
        color: backgroundColor ?? context.colors.primary.withValues(alpha: .15),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: textColor ?? context.colors.onSurface,
                ),
              ),
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color:
                      textColor ??
                      context.colors.onSurface.withValues(alpha: .6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
