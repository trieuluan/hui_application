import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/utils/locale_utils_intl.dart';
import 'package:hui_application/widgets/selection_option_tile.dart';
import 'package:hui_application/core/providers/app_locale_provider.dart';
import 'package:hui_application/core/providers/theme_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: theme.colorScheme.surface,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                S.of(context)!.settings,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 12),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withAlpha(10),
                      theme.colorScheme.primary.withAlpha(5),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // App Preferences Section
                _buildAppPreferencesSection(context, ref),
                const SizedBox(height: 24),

                // Privacy & Security Section
                _buildPrivacySecuritySection(context),
                const SizedBox(height: 24),

                // Support Section
                _buildSupportSection(context),
                const SizedBox(height: 24),

                // About Section
                _buildAboutSection(context),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferencesSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final localeAsync = ref.watch(appLocaleProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'App Preferences', Icons.settings),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.language,
                title: S.of(context)!.language,
                subtitle: localeAsync.when(
                  data:
                      (locale) => LocaleUtilsIntl.getLanguageDisplayName(
                        locale.languageCode,
                      ),
                  loading: () => S.of(context)!.loading,
                  error: (_, __) => S.of(context)!.error,
                ),
                onTap: () => _showLanguageDialog(context, ref),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.brightness_6,
                title: S.of(context)!.theme,
                subtitle: S.of(context)!.light_dark,
                onTap: () => _showThemeDialog(context, ref),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.notifications,
                title: S.of(context)!.notifications,
                subtitle: 'Manage app notifications',
                onTap: () => context.push('/settings/notifications'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.volume_up,
                title: 'Sound & Vibration',
                subtitle: 'App sounds and haptic feedback',
                onTap: () => context.push('/settings/sound'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.data_usage,
                title: 'Data Usage',
                subtitle: 'Manage app data and cache',
                onTap: () => context.push('/settings/data'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySecuritySection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Privacy & Security', Icons.security),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'How we protect your data',
                onTap: () => context.push('/settings/privacy'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.description,
                title: 'Terms of Service',
                subtitle: 'App terms and conditions',
                onTap: () => context.push('/settings/terms'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.fingerprint,
                title: 'Biometric Login',
                subtitle: 'Use fingerprint or face ID',
                trailing: Switch(
                  value: false, // TODO: Implement biometric state
                  onChanged: (value) {
                    // TODO: Implement biometric toggle
                  },
                ),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.lock,
                title: 'App Lock',
                subtitle: 'Lock app with PIN or pattern',
                onTap: () => context.push('/settings/app-lock'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.delete_forever,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                onTap: () => _showDeleteAccountDialog(context),
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Support', Icons.help),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.help_center,
                title: 'Help Center',
                subtitle: 'Find answers to common questions',
                onTap: () => context.push('/settings/help'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.contact_support,
                title: 'Contact Support',
                subtitle: 'Get help from our team',
                onTap: () => context.push('/settings/contact'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.question_answer,
                title: 'FAQ',
                subtitle: 'Frequently asked questions',
                onTap: () => context.push('/settings/faq'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.bug_report,
                title: 'Report a Bug',
                subtitle: 'Help us improve the app',
                onTap: () => context.push('/settings/report-bug'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.feedback,
                title: 'Send Feedback',
                subtitle: 'Share your thoughts with us',
                onTap: () => context.push('/settings/feedback'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'About', Icons.info),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outline.withAlpha(10)),
          ),
          child: Column(
            children: [
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'App Version',
                subtitle: 'Version 1.0.0 (Build 1)',
                onTap: () => _showVersionInfo(context),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.star,
                title: 'Rate App',
                subtitle: 'Rate us on App Store',
                onTap: () => _rateApp(context),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.share,
                title: 'Share App',
                subtitle: 'Share with friends and family',
                onTap: () => _shareApp(context),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.people,
                title: 'Credits',
                subtitle: 'Meet our team',
                onTap: () => context.push('/settings/credits'),
              ),
              _buildDivider(context),
              _SettingsTile(
                icon: Icons.code,
                title: 'Open Source',
                subtitle: 'View source code',
                onTap: () => context.push('/settings/open-source'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 56, right: 16),
      child: Divider(
        height: 1,
        color: Theme.of(context).colorScheme.outline.withAlpha(10),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(appLocaleProvider).valueOrNull;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                S.of(context)!.language,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectionOptionTile(
                title: 'Tiếng Việt',
                subtitle: S.of(context)!.vietnamese,
                icon: Icons.language,
                isSelected: currentLocale?.languageCode == 'vi',
                onTap: () {
                  ref
                      .read(appLocaleProvider.notifier)
                      .setLocale(const Locale('vi'));
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 12),
              SelectionOptionTile(
                title: 'English',
                subtitle: S.of(context)!.english,
                icon: Icons.language,
                isSelected: currentLocale?.languageCode == 'en',
                onTap: () {
                  ref
                      .read(appLocaleProvider.notifier)
                      .setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(appThemeProvider).valueOrNull;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.brightness_6,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                S.of(context)!.theme,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectionOptionTile(
                title: S.of(context)!.light_mode,
                subtitle: 'Light theme',
                icon: Icons.light_mode,
                isSelected: currentTheme == ThemeMode.light,
                onTap: () {
                  ref
                      .read(appThemeProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 12),
              SelectionOptionTile(
                title: S.of(context)!.dark_mode,
                subtitle: 'Dark theme',
                icon: Icons.dark_mode,
                isSelected: currentTheme == ThemeMode.dark,
                onTap: () {
                  ref
                      .read(appThemeProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 12),
              SelectionOptionTile(
                title: S.of(context)!.system_mode,
                subtitle: 'Follow system',
                icon: Icons.settings_system_daydream,
                isSelected: currentTheme == ThemeMode.system,
                onTap: () {
                  ref
                      .read(appThemeProvider.notifier)
                      .setThemeMode(ThemeMode.system);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement account deletion
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showVersionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'App Version',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version: 1.0.0'),
              const SizedBox(height: 8),
              Text('Build: 1'),
              const SizedBox(height: 8),
              Text('Release Date: December 2024'),
              const SizedBox(height: 8),
              Text('Platform: Flutter'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _rateApp(BuildContext context) {
    // TODO: Implement app rating
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening App Store...')));
  }

  void _shareApp(BuildContext context) {
    // TODO: Implement app sharing
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening share dialog...')));
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.primary;

    return ListTile(
      minTileHeight: 64,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDestructive ? theme.colorScheme.error : null,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
              : null,
      trailing:
          trailing ??
          (onTap != null
              ? Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              )
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
