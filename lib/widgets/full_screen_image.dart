import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/helpers/theme_helper/theme_helper.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';
import 'package:practical_pachprthlo/widgets/image_load_error_widget.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(imageUrl),
                  errorBuilder: (context, error, stackTrace) => const ImageLoadErrorWidget(),
                  loadingBuilder: (context, event) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  backgroundDecoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              Positioned(
                top: getMediaQueryHeight(context, 0.02),
                left: getMediaQueryWidth(context, 0.035),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_outlined, color: ThemeHelper.isThemeLight(context) ? kBlackColor : kWhiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
