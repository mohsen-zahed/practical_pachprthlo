import 'package:flutter/material.dart';

import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/localization_bottom_sheet_modal.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/widgets/theme_bottom_sheet_modal.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                title: const Text('Theme mode'),
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
                title: const Text('Language'),
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
