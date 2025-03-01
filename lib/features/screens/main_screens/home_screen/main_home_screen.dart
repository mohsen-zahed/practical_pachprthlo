import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/providers/internet_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/home_screen.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/provider_screen_ex/provider_screen_ex.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/settings_screen.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/statistic_screen.dart';
import 'package:practical_pachprthlo/packages/connectivity_plus_package/my_connectivity_plus_package_const.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

int homeIndex = 0;
int statisticIndex = 1;
int providerScreenExIndex = 2;
int settingsScreenIndex = 3;

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _providerKey = GlobalKey();
  final GlobalKey<NavigatorState> _settingsKey = GlobalKey();
  // late InternetCubit internetCubit;

  late final map = {
    homeIndex: _homeKey,
    statisticIndex: _searchKey,
    providerScreenExIndex: _providerKey,
    settingsScreenIndex: _settingsKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState = map[selectedScreenIndex]!.currentState!;

    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false; //* Prevents default back navigation
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false; //* Prevents default back navigation
    } else {
      return true; //* Allows default back navigation (exits the app)
    }
  }

  @override
  void initState() {
    super.initState();
    // internetCubit = context.read<InternetCubit>();
    // internetCubit.checkConnectivity();
    // internetCubit.trackConnectivityChange();
  }

  @override
  void dispose() {
    super.dispose();
    // internetCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (f) => _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: selectedScreenIndex,
              children: [
                _navigator(_homeKey, homeIndex, const HomeScreen()),
                _navigator(_searchKey, statisticIndex, const StatisticScreen()),
                _navigator(_providerKey, providerScreenExIndex, const ProviderScreenEx()),
                _navigator(_settingsKey, settingsScreenIndex, const SettingsScreen()),
              ],
            ),
            context.read<InternetProvider>().showInternetBanner
                ? AnimatedPositioned(
                    duration: const Duration(milliseconds: 2000),
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: getScreenArea(context, 0.000015)),
                      decoration: BoxDecoration(color: isConnected ? kGreenColor : kRedColor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              isConnected ? Icons.wifi : Icons.wifi_off,
                              color: kWhiteColor,
                              size: getScreenArea(context, 0.00006),
                            ),
                            SizedBox(width: getScreenArea(context, 0.000015)),
                            Text(
                              isConnected ? AppLocalizations.of(context)!.backOnlineText : AppLocalizations.of(context)!.currentlyOfflineText,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor, letterSpacing: 1.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreenIndex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedScreenIndex);
              _history.add(selectedScreenIndex);
              selectedScreenIndex = selectedIndex;
              debugPrint(_history.toString());
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.homeText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.stacked_bar_chart),
              label: AppLocalizations.of(context)!.statisticsText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.preview_outlined),
              label: AppLocalizations.of(context)!.providerText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settingsText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? const SizedBox()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}
