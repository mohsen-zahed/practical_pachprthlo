import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/a-language_model/language_model.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationBottomSheetModal extends StatelessWidget {
  const LocalizationBottomSheetModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            final bool isLightThemeChosen = Languages.values[index] == state.selectedLanguage;
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
                trailing: Icon(isLightThemeChosen ? Icons.check_circle : Icons.circle_outlined),
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
                        content: Text("${AppLocalizations.of(context)!.languageChangedTo} ${state.selectedLanguage.name}"),
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
    );
  }
}
