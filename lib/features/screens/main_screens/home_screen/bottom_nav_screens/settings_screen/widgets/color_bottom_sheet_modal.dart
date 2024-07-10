import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/data/models/c-color_model/color_model.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/helpers/pop_up_helpers/confirmation_pop_up_box.dart';
import 'package:practical_pachprthlo/helpers/theme_helper/color_helper.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class ColorBottomSheetModal extends StatelessWidget {
  const ColorBottomSheetModal({
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
              Text(AppLocalizations.of(context)!.changeAppColorText, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: getScreenArea(context, 0.00005)),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: getScreenArea(context, 0.00003)),
                    child: ListTile(
                      leading: Container(
                        width: getScreenArea(context, 0.0001),
                        height: getScreenArea(context, 0.0001),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(image: AssetImage(ColorModel.values[index].colorPath.path), fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(ColorModel.values[index].name),
                      trailing: Icon(
                        Icons.circle,
                        color: index == ColorModel.values.first.index
                            ? context.watch<ColorProvider>().primaryColor
                            : context.watch<ColorProvider>().secondaryColor,
                      ),
                      onTap: index == ColorModel.values.first.index
                          ? () async {
                              ColorHelper.showColorPicker(context, true);
                              Navigator.pop(context);
                            }
                          : () async {
                              ColorHelper.showColorPicker(context, false);
                              Navigator.pop(context);
                            },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: getScreenArea(context, 0.00001));
                },
                itemCount: ColorModel.values.length,
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
                  context.read<ColorProvider>().resetThemeColors();
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
