import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/dependency_injection/di.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/theme_bloc/theme_bloc.dart';
import 'package:practical_pachprthlo/features/providers/categories_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/bloc/diseases_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/bloc/statistic_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/main_home_screen.dart';
import 'package:practical_pachprthlo/features/providers/counter_provider.dart';
import 'package:practical_pachprthlo/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

///*** ************************************************* ***\\\
//* This is a project for testing, a combination of *\\
//* Pagination, search, charts, provider, and hive DB! *\\
//* HiveDB's structure is better implemented in this project than the one in the NewsAppProject. *\\
///*** ************************************************* ***\\\

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiseaseBloc>(
          create: (context) => di<DiseaseBloc>()..add(FetchDiseases()),
        ),
        BlocProvider<StatisticBloc>(
          create: (context) => di<StatisticBloc>()..add(StatisticReloaded()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => di<ThemeBloc>()..add(GetTheme()),
        ),
        BlocProvider<LocalizationBloc>(
          create: (context) => di<LocalizationBloc>()..add(GetLocalization()),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CounterProvider()),
          ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Practical pachprthlo',
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: state.selectedTheme.themeMode,
              debugShowCheckedModeBanner: false,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const MainHomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
