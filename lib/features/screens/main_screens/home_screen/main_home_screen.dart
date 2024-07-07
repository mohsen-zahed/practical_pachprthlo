import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/home_screen.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/provider_screen_ex/provider_screen_ex.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/settings_screen/settings_screen.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/statistic_screen/statistic_screen.dart';

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
      return false; // Prevent default back navigation
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false; // Prevent default back navigation
    } else {
      return true; // Allow default back navigation (exits the app)
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (f) => _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(_homeKey, homeIndex, const HomeScreen()),
            _navigator(_searchKey, statisticIndex, const StatisticScreen()),
            _navigator(_providerKey, providerScreenExIndex, const ProviderScreenEx()),
            _navigator(_settingsKey, settingsScreenIndex, const SettingsScreen()),
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
