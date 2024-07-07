import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/dependency_injection/di.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/providers/categories_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/bloc/diseases_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/sub_screens/search_screen/search_screen.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/widgets/single_disease_card_widget.dart';
import 'package:practical_pachprthlo/packages/connectivity_plus_package/my_connectivity_plus_package.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DiseaseBloc? _bloc;
  StreamSubscription? _streamSubscription;

  @override
  void dispose() {
    super.dispose();
    _bloc?.close();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.practicalPachprthloText, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kWhiteColor)),
        actions: [
          BlocConsumer<DiseaseBloc, DiseasesStatus>(
            builder: (context, state) {
              if (state.diseasesState is DiseasesSuccess) {
                final DiseasesSuccess diseaseResponseModel = state.diseasesState as DiseasesSuccess;
                return IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => SearchScreen(diseaseList: diseaseResponseModel.diseaseResponseModel.diseaseModelList),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                );
              }
            },
            listener: (BuildContext context, DiseasesStatus state) {},
          ),
        ],
      ),
      body: BlocConsumer<DiseaseBloc, DiseasesStatus>(
        buildWhen: (previous, current) {
          return previous.diseasesState != current.diseasesState;
        },
        listenWhen: (previous, current) {
          return previous.diseasesState != current.diseasesState;
        },
        builder: (builderContext, state) {
          if (state.diseasesState is DiseasesSuccess) {
            final DiseasesSuccess diseaseResponseStatus = state.diseasesState as DiseasesSuccess;
            final List<DiseaseModel> diseaseList = diseaseResponseStatus.diseaseResponseModel.diseaseModelList;

            //* Succuss state...
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<DiseaseBloc>(context).add(FetchDiseases());
              },
              child: ListView.builder(
                controller: BlocProvider.of<DiseaseBloc>(context).scrollController,
                itemCount: BlocProvider.of<DiseaseBloc>(context).isLoadingMore ? diseaseList.length + 1 : diseaseList.length,
                itemBuilder: (context, index) {
                  if (index >= diseaseList.length) {
                    return Column(
                      children: [
                        SizedBox(height: getScreenArea(context, 0.00001)),
                        const CupertinoActivityIndicator(),
                        SizedBox(height: getScreenArea(context, 0.000007)),
                        Text(AppLocalizations.of(context)!.loadingMoreText, style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(height: getScreenArea(context, 0.00004)),
                      ],
                    );
                  } else {
                    return SingleDiseaseCardWidget(diseaseModel: diseaseList[index], index: index);
                  }
                },
              ),
            );
          }
          if (state.diseasesState is DiseasesFailed) {
            final error = state.diseasesState as DiseasesFailed;
            //* Failure state...
            return Column(
              children: [
                Icon(Icons.error, size: getScreenArea(context, 0.00005)),
                Center(child: Text(error.errorMessage)),
                ElevatedButton(
                  onPressed: () {
                    context.read<DiseaseBloc>().add(FetchDiseases());
                  },
                  child: Text(AppLocalizations.of(context)!.tryAgainText),
                ),
              ],
            );
          }
          if (state.diseasesState is DiseasesLoading) {
            //* Loading state...
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  SizedBox(height: getScreenArea(context, 0.00003)),
                  Text(AppLocalizations.of(context)!.loadingCreatureText, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }
          return Container();
        },
        listener: (BuildContext context, DiseasesStatus state) async {
          if (state.diseasesState is DiseasesSuccess) {
            final list = (state.diseasesState as DiseasesSuccess).diseaseResponseModel.diseaseModelList;
            for (var i = 0; i < list.length; i++) {
              context.read<CategoriesProvider>().addCategory(list[i].species);
              context.read<CategoriesProvider>().addCategory(list[i].gender);
              context.read<CategoriesProvider>().addCategory(list[i].location);
              context.read<CategoriesProvider>().addCategory(list[i].origin);
              context.read<CategoriesProvider>().addCategory(list[i].type);
            }
            await di<MyConnectivityPlusPackage>().checkInternetConnection().then(
              (value) {
                final String source = value ? AppLocalizations.of(context)!.apiText : AppLocalizations.of(context)!.databaseText;
                String msg = "${AppLocalizations.of(context)!.dataRetrievedFromText} $source";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
