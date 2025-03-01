import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/a-language_model/language_model.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/helpers/pop_up_helpers/confirmation_pop_up_box.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class LocalizationBottomSheetModal extends StatelessWidget {
  const LocalizationBottomSheetModal({
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
              Text(AppLocalizations.of(context)!.changeLanguageText, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: getScreenArea(context, 0.00005)),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BlocBuilder<LocalizationBloc, LocalizationState>(
                    builder: (context, state) {
                      final bool isLanguageChosen = Languages.values[index] == state.selectedLanguage;
                      return Padding(
                        padding: EdgeInsets.only(bottom: getScreenArea(context, 0.00003)),
                        child: ListTile(
                          leading: Container(
                            width: getScreenArea(context, 0.0001),
                            height: getScreenArea(context, 0.0001),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(image: AssetImage(Languages.values[index].iconPath.path), fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(Languages.values[index].name),
                          trailing: Icon(isLanguageChosen ? Icons.check_circle : Icons.circle_outlined),
                          onTap: () async {
                            context.read<LocalizationBloc>().add(ChangeLocalization(selectedLanguage: Languages.values[index]));
                            await Future.delayed(
                              const Duration(milliseconds: 0),
                              () {
                                Navigator.pop(context);
                              },
                            ).then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("${AppLocalizations.of(context)!.languageChangedToText} ${Languages.values[index].name}"),
                                ));
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
                itemCount: Languages.values.length,
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
                  context.read<LocalizationBloc>().add(const ResetLocalization(key: languageKey));
                  Navigator.pop(context); //* For BottomSheetModal...
                },
                onCancel: () {
                  Navigator.pop(context); //* For BottomSheetModal...
                },
              );
            },
            icon: Icon(Icons.restart_alt_outlined, color: context.watch<ColorProvider>().primaryColor),
          ),
        ),
      ],
    );
  }
}
