import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/theme_bloc/theme_bloc.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/features/providers/font_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/color_bottom_sheet_modal.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/font_bottom_sheet_modal.dart';

import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/localization_bottom_sheet_modal.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/theme_bottom_sheet_modal.dart';
import 'package:practical_pachprthlo/helpers/pop_up_helpers/confirmation_pop_up_box.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color pickedColor = kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsScreenText),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                showConfirmationDialogBox(
                  context,
                  '',
                  titleText: AppLocalizations.of(context)!.resetBackToDefaultText,
                  onConfirm: () {
                    context.read<ThemeBloc>().add(const ResetThemeMode(key: themeKey));
                    context.read<LocalizationBloc>().add(const ResetLocalization(key: languageKey));
                    context.read<ColorProvider>().resetThemeColors();
                    context.read<FontProvider>().resetFontFamily();
                  },
                  onCancel: () {},
                );
              },
              child: Text(
                AppLocalizations.of(context)!.resetAllText,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: context.watch<ColorProvider>().primaryColor),
              ),
            ),
            SizedBox(height: getScreenArea(context, 0.00005)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.0001)),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return const ThemeBottomSheetModal();
                    },
                  );
                },
                leading: const Icon(Icons.palette),
                title: Text(AppLocalizations.of(context)!.appThemeModeText),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: getScreenArea(context, 0.00005),
                ),
              ),
            ),
            SizedBox(height: getScreenArea(context, 0.00005)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.0001)),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return const LocalizationBottomSheetModal();
                    },
                  );
                },
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.appLanguageText),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: getScreenArea(context, 0.00005),
                ),
              ),
            ),
            SizedBox(height: getScreenArea(context, 0.00005)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.0001)),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return const ColorBottomSheetModal();
                    },
                  );
                },
                leading: const Icon(Icons.colorize_rounded),
                title: Text(AppLocalizations.of(context)!.changeAppColorText),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: getScreenArea(context, 0.00005),
                ),
              ),
            ),
            SizedBox(height: getScreenArea(context, 0.00005)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.0001)),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return const FontBottomSheetModal();
                    },
                  );
                },
                leading: const Icon(Icons.font_download_rounded),
                title: Text(AppLocalizations.of(context)!.appFontText),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: getScreenArea(context, 0.00005),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
