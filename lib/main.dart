import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vn_crypto/bloc/theme/theme_bloc.dart';
import 'package:vn_crypto/bloc/theme/theme_state.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/BottomNav.dart';
import 'package:vn_crypto/ui/components/route/AppRoute.dart';
import 'package:vn_crypto/ui/home/home_page.dart';
import 'package:vn_crypto/ui/investmanagement/invest_management_page.dart';
import 'package:vn_crypto/ui/screen/ListCoinScreen.dart';
import 'package:vn_crypto/ui/screen/about_app_screen.dart';

void main() async {
  await configureInjection();
  runApp(ChangeNotifierProvider(
    create: (_) => IndexNavigation(0),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) => MaterialApp(
                  theme: ThemeData(
                      brightness: state is DarkThemeState
                          ? Brightness.dark
                          : Brightness.light,
                      primaryColor: Colors.white,
                      appBarTheme: const AppBarTheme(color: Colors.white)),
                  debugShowCheckedModeBanner: false,
                  home: const MainScreen(),
                )),
      );
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class IndexNavigation with ChangeNotifier {
  int selectedIndex;

  IndexNavigation(this.selectedIndex);

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: IndexedStack(
            index: Provider.of<IndexNavigation>(context).selectedIndex,
            children: const [
              HomePage(),
              ListCoinScreen(),
              InvestManagementScreen(),
              AboutAppScreen()
            ],
          ),
          bottomNavigationBar: BottomNav(
            onTap: (int i) {
              Provider.of<IndexNavigation>(context, listen: false).setIndex(i);
            },
            selectedIndex: Provider.of<IndexNavigation>(context).selectedIndex,
          )),
      onGenerateRoute: appRoutes,
    );
  }
}
