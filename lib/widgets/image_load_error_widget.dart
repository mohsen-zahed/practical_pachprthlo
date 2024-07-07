import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class ImageLoadErrorWidget extends StatelessWidget {
  const ImageLoadErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Failed to load image!', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kGreyColorShade600)),
          SizedBox(height: getScreenArea(context, 0.00005)),
          Icon(
            Icons.broken_image_rounded,
            color: kGreyColor,
            size: getScreenArea(context, 0.00015),
          ),
        ],
      ),
    );
  }
}
