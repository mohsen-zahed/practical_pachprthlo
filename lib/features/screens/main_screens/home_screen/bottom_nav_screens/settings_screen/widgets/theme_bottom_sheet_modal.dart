import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/features/blocs/theme_bloc/theme_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/b-theme_model/theme_model.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/helpers/pop_up_helpers/confirmation_pop_up_box.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class ThemeBottomSheetModal extends StatelessWidget {
  const ThemeBottomSheetModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.changeThemeText, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: getScreenArea(context, 0.00005)),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      final bool isLightThemeChosen = Themes.values[index] == state.selectedTheme;
                      return Padding(
                        padding: EdgeInsets.only(bottom: getScreenArea(context, 0.00003)),
                        child: ListTile(
                          tileColor: state.selectedTheme.themeMode == ThemeMode.dark
                              ? kGreyColorShade900
                              : state.selectedTheme.themeMode == ThemeMode.system
                                  ? null
                                  : kWhiteColor,
                          leading: Container(
                            width: getScreenArea(context, 0.0001),
                            height: getScreenArea(context, 0.0001),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(image: AssetImage(Themes.values[index].iconPath), fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(Themes.values[index].name),
                          trailing: Icon(isLightThemeChosen ? Icons.check_circle : Icons.circle_outlined),
                          onTap: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                context.read<ThemeBloc>().add(ChangeThemeMode(selectedTheme: Themes.values[index]));
                              },
                            ).then(
                              (value) async {
                                await Future.delayed(
                                  const Duration(milliseconds: 700),
                                  () {
                                    Navigator.pop(context);
                                  },
                                ).then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("${AppLocalizations.of(context)!.themeChangedToText} ${Themes.values[index].name}"),
                                    ));
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: getScreenArea(context, 0.00001));
                },
                itemCount: Themes.values.length,
              ),
            ],
          ),
        ),
        Positioned(
          top: getScreenArea(context, -0.000045),
          right: getScreenArea(context, 0.00004),
          child: IconButton(
            onPressed: () {
              showConfirmationDialogBox(
                context,
                '',
                titleText: AppLocalizations.of(context)!.resetBackToDefaultText,
                onConfirm: () {
                  context.read<ThemeBloc>().add(const ResetThemeMode(key: themeKey));
                  Navigator.pop(context); //* This is for BottomSheetModal to pop back...
                },
                onCancel: () {
                  Navigator.pop(context); //* This is for BottomSheetModal to pop back...
                },
              );
            },
            icon: Icon(
              Icons.restart_alt_outlined,
              color: context.watch<ColorProvider>().primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
