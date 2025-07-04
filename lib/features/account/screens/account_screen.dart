import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/core/utils/locale_utils_intl.dart';
import 'package:hui_application/widgets/selection_option_tile.dart';
import 'package:hui_application/features/auth/models/auth_state.dart';
import 'package:hui_application/features/auth/providers/auth_provider.dart';
import 'package:hui_application/models/users.dart';
import 'package:hui_application/widgets/avatar_widget.dart';
import 'package:hui_application/core/providers/app_locale_provider.dart';
import 'package:hui_application/core/providers/theme_provider.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Widget _buildProfileCard(BuildContext context, User user) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                AvatarWidget(
                  displayName: user.fullName,
                  imageUrl: null,
                  radius: 35,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).iconTheme.color?.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              user.email ?? S.of(context)!.no_email_provided,
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 16,
                            color: Theme.of(
                              context,
                            ).iconTheme.color?.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              user.phone ?? S.of(context)!.no_phone_provided,
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.push('/account/profile');
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  tooltip: S.of(context)!.edit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> tiles) {
    return Card(elevation: 2, child: Column(children: tiles));
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).user;
    final localeAsync = ref.watch(appLocaleProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(S.of(context)!.account), centerTitle: true),
        body: Center(child: const CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.account), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileCard(context, user),
          const SizedBox(height: 16),
          _buildSection([
            _AccountTile(
              icon: Icons.person,
              title: S.of(context)!.profile,
              onTap: () {
                context.push('/account/profile');
              },
            ),
            _AccountTile(
              icon: Icons.security,
              title: S.of(context)!.security,
              onTap: () {
                context.push('/account/security');
              },
            ),
            _AccountTile(
              icon: Icons.notifications,
              title: S.of(context)!.notifications,
              onTap: () {
                context.push('/account/notifications');
              },
            ),
            _AccountTile(
              icon: Icons.payment,
              title: S.of(context)!.payment_methods,
              onTap: () {
                context.push('/account/payment');
              },
            ),
            _AccountTile(
              icon: Icons.history,
              title: S.of(context)!.transaction_history,
              onTap: () {
                context.push('/account/transactions');
              },
            ),
            _AccountTile(
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
              onTap: () {
                _showLanguageDialog(context, ref);
              },
            ),
            _AccountTile(
              icon: Icons.brightness_6,
              title: S.of(context)!.theme,
              subtitle: S.of(context)!.light_dark,
              onTap: () {
                _showThemeDialog(context, ref);
              },
            ),
            _AccountTile(
              icon: Icons.help,
              title: S.of(context)!.help_support,
              onTap: () {
                context.push('/account/help');
              },
            ),
            _AccountTile(
              icon: Icons.settings,
              title: S.of(context)!.settings,
              onTap: () {
                context.push('/account/settings');
              },
            ),
            _AccountTile(
              icon: Icons.logout,
              title: S.of(context)!.logout,
              onTap: () {
                ref.read(authNotifierProvider.notifier).logout();
                context.go('/login');
              },
            ),
          ]),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _AccountTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    minTileHeight: 64, // Tăng height cho better touch target
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    subtitle:
        subtitle != null
            ? Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
            : null,
    trailing: Icon(
      Icons.chevron_right,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      size: 20,
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
