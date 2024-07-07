import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';
import 'package:practical_pachprthlo/widgets/full_screen_image.dart';

class SingleDiseaseCardWidget extends StatelessWidget {
  final DiseaseModel diseaseModel;
  final int index;
  const SingleDiseaseCardWidget({
    super.key,
    required this.diseaseModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(
        getScreenArea(context, 0.00004),
        index == 0 ? getScreenArea(context, 0.00004) : 0,
        getScreenArea(context, 0.00004),
        getScreenArea(context, 0.00004),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getScreenArea(context, 0.00003),
          vertical: getScreenArea(context, 0.00003),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(builder: (context) => FullScreenImage(imageUrl: diseaseModel.image)));
              },
              child: Container(
                height: getScreenArea(context, 0.001),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(diseaseModel.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: double.infinity,
                        height: getMediaQueryHeight(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: gradientColors,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: getScreenArea(context, 0.00006),
                      left: getScreenArea(context, 0.00006),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getScreenArea(context, 0.00003),
                              vertical: getScreenArea(context, 0.000001),
                            ),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              diseaseModel.species,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(height: getScreenArea(context, 0.00003)),
                          Text(
                            diseaseModel.createdOn.toString(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kWhiteColor),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: getScreenArea(context, 0.00003),
                      right: getScreenArea(context, 0.00004),
                      child: Text(
                        'Image by: ${diseaseModel.name}',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpansionTile(
              childrenPadding: const EdgeInsets.all(0),
              tilePadding: const EdgeInsets.all(0),
              title: Padding(
                padding: EdgeInsets.only(bottom: getScreenArea(context, 0.000015)),
                child: Text(
                  diseaseModel.name,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              subtitle: Wrap(
                children: [
                  _buildInfoChip(context, diseaseModel.species),
                  SizedBox(width: getScreenArea(context, 0.000015)),
                  _buildInfoChip(context, diseaseModel.gender),
                  SizedBox(width: getScreenArea(context, 0.000015)),
                  _buildInfoChip(context, diseaseModel.location),
                  SizedBox(width: getScreenArea(context, 0.000015)),
                  _buildInfoChip(context, diseaseModel.origin),
                  SizedBox(width: getScreenArea(context, 0.000015)),
                  _buildInfoChip(context, diseaseModel.type),
                ],
              ),
              children: [
                SizedBox(height: getScreenArea(context, 0.00001)),
                SizedBox(height: getScreenArea(context, 0.00001)),
                Text(
                  "In the remote depths of an uncharted galaxy, on a planet known as Xylotria, bizarre and extraordinary creatures roamed the iridescent landscapes. The skies shimmered with hues unknown to Earth's spectrum, casting an otherworldly glow over the alien flora and fauna. Among these creatures were the Luminaris, ethereal beings that floated effortlessly, their translucent bodies pulsating with vibrant, shifting colors. These creatures communicated through harmonious light patterns, creating a mesmerizing display that illuminated the forest canopy like a living aurora borealis. The ground was teeming with Ryzaks, six-legged beings covered in bioluminescent scales, whose intricate dance resembled a choreographed ballet, their movements echoing the rhythm of the planet's deep, resonant heartbeat.\nIn the cavernous underground labyrinths of Xylotria, the enigmatic Glowers thrived. These subterranean creatures had bioluminescent eyes that pierced through the darkness, casting eerie glows on the crystalline walls. The Glowers possessed a unique ability to manipulate their surroundings with a form of telekinesis, effortlessly shifting massive boulders and creating pathways as they navigated the labyrinths. It was rumored among the Luminaris that the Glowers held ancient knowledge of the planet’s secrets, passed down through generations in a silent, telepathic language. The symbiotic relationship between the Luminaris, Ryzaks, and Glowers formed a delicate balance, each species contributing to the vibrant and enigmatic ecosystem of Xylotria.",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label) {
    return Container(
      decoration: BoxDecoration(
        color: kGreyColorShade200,
        borderRadius: BorderRadius.circular(3),
      ),
      margin: EdgeInsets.symmetric(vertical: getScreenArea(context, 0.000015)),
      padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.000015)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kBlackColor),
      ),
    );
  }
}
