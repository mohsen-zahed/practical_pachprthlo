import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/a-language_model/language_model.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/features/providers/font_provider.dart';
import 'package:practical_pachprthlo/helpers/pop_up_helpers/confirmation_pop_up_box.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class FontBottomSheetModal extends StatefulWidget {
  const FontBottomSheetModal({
    super.key,
  });

  @override
  State<FontBottomSheetModal> createState() => _FontBottomSheetModalState();
}

class _FontBottomSheetModalState extends State<FontBottomSheetModal> {
  List<String> fontsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, languageState) {
        bool isEnglishLang = true;
        if (languageState.selectedLanguage == Languages.english) {
          isEnglishLang = true;
        } else {
          isEnglishLang = false;
        }
        if (isEnglishLang) {
          fontsList = context.read<FontProvider>().englishFontsList;
        } else {
          fontsList = context.read<FontProvider>().persianFontsList;
        }
        return Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.changeDisplayFontText, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: getScreenArea(context, 0.00005)),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          getScreenArea(context, 0.00007),
                          getScreenArea(context, 0.00007),
                          getScreenArea(context, 0.00007),
                          index == fontsList.length - 1 ? getScreenArea(context, 0.00005) : 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00003)),
                              child: Text(
                                fontsList[index],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizedBox(height: getScreenArea(context, 0.000012)),
                            ListTile(
                              leading: const Icon(Icons.font_download_rounded),
                              // Container(
                              //   width: getScreenArea(context, 0.0001),
                              //   height: getScreenArea(context, 0.0001),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(100),
                              //     image: DecorationImage(image: AssetImage(FontModel.values[index].iconPath), fit: BoxFit.cover),
                              //   ),
                              // ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onTap: () async {
                                context.read<FontProvider>().updateFontFamily(fontsList[index], 18);
                                await Future.delayed(
                                  const Duration(milliseconds: 0),
                                  () {
                                    Navigator.pop(context);
                                  },
                                ).then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("${AppLocalizations.of(context)!.fontSuccessfullyChangedToText} ${fontsList[index]}"),
                                    ));
                                  },
                                );
                              },
                              title: Text(
                                "${AppLocalizations.of(context)!.thisIsASampleOfText} ${fontsList[index]}",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontFamily: fontsList[index]),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: getScreenArea(context, 0.0000));
                    },
                    itemCount: fontsList.length,
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
                      context.read<FontProvider>().resetFontFamily();
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
      },
    );
  }
}
