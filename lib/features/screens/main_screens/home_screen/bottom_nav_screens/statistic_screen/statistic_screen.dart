import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/data/repository/remote/remote_statistic_repository.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/bloc/statistic_bloc.dart';
import 'package:practical_pachprthlo/packages/fl_chart_package/my_fl_chart_package.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticBloc>(
      create: (context) => StatisticBloc(statisticRepository)..add(StatisticRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.statisticReviewText),
        ),
        body: BlocBuilder<StatisticBloc, StatisticStatus>(
          builder: (context, state) {
            if (state.statisticState is StatisticSuccess) {
              final newSuccessState = state.statisticState as StatisticSuccess;
              final List<dynamic> chartValuesList = [];
              chartValuesList.add(newSuccessState.statisticList[0].volumeWeightedAveragePrice);
              chartValuesList.add(newSuccessState.statisticList[0].open);
              chartValuesList.add(newSuccessState.statisticList[0].close);
              chartValuesList.add(newSuccessState.statisticList[0].high);
              chartValuesList.add(newSuccessState.statisticList[0].low);
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScreenArea(context, 0.0001),
                    vertical: getScreenArea(context, 0.0001),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getScreenArea(context, 0.001),
                        child: MyFlChartPackage.instance.drawPieChart(
                          sections: chartValuesList,
                          colors: [
                            kPrimaryColor,
                            kGreenColor,
                            kBlueColor,
                            kRedColor,
                            kYellowColor,
                          ],
                        ),
                      ),
                      SizedBox(height: getScreenArea(context, 0.0002)),
                      SizedBox(
                        height: getScreenArea(context, 0.001),
                        child: MyFlChartPackage.instance.drawLineChart(),
                      ),
                      SizedBox(height: getScreenArea(context, 0.0002)),
                      SizedBox(
                        height: getScreenArea(context, 0.001),
                        child: MyFlChartPackage.instance.drawBarChart(),
                      ),
                      SizedBox(height: getScreenArea(context, 0.0002)),
                      SizedBox(
                        height: getScreenArea(context, 0.001),
                        child: MyFlChartPackage.instance.drawScatterChart(),
                      ),
                      SizedBox(height: getScreenArea(context, 0.0002)),
                      SizedBox(
                        height: getScreenArea(context, 0.001),
                        child: MyFlChartPackage.instance.drawRadarChart(),
                      ),
                      SizedBox(height: getScreenArea(context, 0.0002)),
                    ],
                  ),
                ),
              );
            } else if (state.statisticState is StatisticFailed) {
              final newFailedState = state.statisticState as StatisticFailed;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(newFailedState.errorMessage),
                    SizedBox(height: getScreenArea(context, 0.00003)),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StatisticBloc>().add(StatisticRequested());
                      },
                      child: Text(AppLocalizations.of(context)!.refreshText),
                    ),
                  ],
                ),
              );
            } else if (state.statisticState is StatisticLoading) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(),
                    SizedBox(height: getScreenArea(context, 0.00003)),
                    Text(AppLocalizations.of(context)!.statisticsAreGettingReadyText, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${AppLocalizations.of(context)!.somethingWentWrongText}\n${AppLocalizations.of(context)!.tryToRefreshTheScreenText}"),
                    SizedBox(height: getScreenArea(context, 0.00003)),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StatisticBloc>().add(StatisticRequested());
                      },
                      child: Text(AppLocalizations.of(context)!.refreshText),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
