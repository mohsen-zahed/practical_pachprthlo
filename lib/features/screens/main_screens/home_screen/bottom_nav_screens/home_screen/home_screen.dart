import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/dependency_injection/di.dart';
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
        title: Text('Pagination with Search Test', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kWhiteColor)),
        actions: [
          BlocConsumer<DiseaseBloc, DiseasesStatus>(
            builder: (context, state) {
              if (state.diseasesState is DiseasesSuccess) {
                final DiseasesSuccess diseaseResponseModel = state.diseasesState as DiseasesSuccess;

                return IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(
                        builder: (context) => SearchScreen(diseaseList: diseaseResponseModel.diseaseModelList.diseaseModel),
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
        builder: (context, state) {
          if (state.diseasesState is DiseasesSuccess) {
            final DiseasesSuccess diseaseResponseModel = state.diseasesState as DiseasesSuccess;
            //* Succuss state...
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<DiseaseBloc>(context).add(FetchDiseases());
              },
              child: ListView.builder(
                controller: BlocProvider.of<DiseaseBloc>(context).scrollController,
                itemCount: BlocProvider.of<DiseaseBloc>(context).isLoadingMore
                    ? diseaseResponseModel.diseaseModelList.diseaseModel.length + 1
                    : diseaseResponseModel.diseaseModelList.diseaseModel.length,
                itemBuilder: (context, index) {
                  if (index >= diseaseResponseModel.diseaseModelList.diseaseModel.length) {
                    return Column(
                      children: [
                        SizedBox(height: getScreenArea(context, 0.00001)),
                        const CupertinoActivityIndicator(),
                        SizedBox(height: getScreenArea(context, 0.000007)),
                        Text('Loading More...', style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(height: getScreenArea(context, 0.00004)),
                      ],
                    );
                  } else {
                    return SingleDiseaseCardWidget(diseaseModel: diseaseResponseModel.diseaseModelList.diseaseModel[index], index: index);
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
                  child: const Text('Try again'),
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
                  Text('Loading Creatures...', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }
          return Container();
        },
        listener: (BuildContext context, DiseasesStatus state) async {
          if (state.diseasesState is DiseasesSuccess) {
            await di<MyConnectivityPlusPackage>().checkInternetConnection().then(
              (value) {
                final String source = value ? "API" : "Database";
                String msg = "Data retrieved from $source";
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
