import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/a-language_model/language_model.dart';
import 'package:practical_pachprthlo/features/providers/font_provider.dart';
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
        return SizedBox(
          child: SingleChildScrollView(
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
        );
      },
    );
  }
}
