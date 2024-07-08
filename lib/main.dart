import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/dependency_injection/di.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/blocs/theme_bloc/theme_bloc.dart';
import 'package:practical_pachprthlo/features/providers/categories_provider.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/bloc/diseases_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/bloc/statistic_bloc.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/main_home_screen.dart';
import 'package:practical_pachprthlo/features/providers/counter_provider.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/packages/flutter_colorpicker_package/my_flutter_colorpicker_package_const.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';
import 'package:practical_pachprthlo/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///*** ************************************************* ***\\\
//* This is a project for testing, a combination of *\\
//* Pagination, search, charts, provider, and hive DB! *\\
//* HiveDB's structure is better implemented in this project than the one in the NewsAppProject. *\\
///*** ************************************************* ***\\\

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  final x = await SharedPreferences.getInstance();
  print("lang: ${x.getString(languageKey)}");
  // x.clear();
  print("theme: ${x.getString(themeKey)}");
  print("color: ${x.getString(primaryColorKey)}");
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
          ChangeNotifierProvider(create: (context) => ColorProvider()),
        ],
        child: Consumer<ColorProvider>(
          builder: (context, color, child) {
            return BlocBuilder<LocalizationBloc, LocalizationState>(
              buildWhen: (previous, current) => previous.selectedLanguage != current.selectedLanguage,
              builder: (context, languageState) {
                return BlocBuilder<ThemeBloc, ThemeState>(
                  buildWhen: (previous, current) => previous.selectedTheme != current.selectedTheme,
                  builder: (context, themeState) {
                    return MaterialApp(
                      title: 'Practical pachprthlo',
                      theme: AppTheme.lightTheme(primaryColor: color.primaryColor),
                      darkTheme: AppTheme.darkTheme(primaryColor: color.primaryColor),
                      themeMode: themeState.selectedTheme.themeMode,
                      debugShowCheckedModeBanner: false,
                      supportedLocales: AppLocalizations.supportedLocales,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
                      locale: languageState.selectedLanguage.locale,
                      home: const MainHomeScreen(),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
