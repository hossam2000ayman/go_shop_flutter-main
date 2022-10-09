import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goshop/modules/zoom_drawer.dart';
import 'package:goshop/remoteNetwork/cacheHelper.dart';
import 'package:goshop/remoteNetwork/dioHelper.dart';
import 'package:goshop/shared/bloc_observer.dart';
import 'package:goshop/shared/constants.dart';
import 'package:goshop/shared/themes.dart';
import 'cubit/appCubit.dart';
import 'cubit/shopCubit.dart';
import 'cubit/states.dart';
import 'modules/LoginScreen.dart';
import 'modules/OnBoardingScreen.dart';
import 'modules/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();


  Widget widget;

  bool? isDark = CacheHelper.getData('isDark');
  bool? showOnBoard = CacheHelper.getData('ShowOnBoard');
  token = CacheHelper.getData('token');

  if(showOnBoard == false) {
    if (token != null)
      widget = ZDrawer();
    else
      widget = LoginScreen();
  }
  else
    widget = OnBoarding();
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  late final Widget startWidget;
  MyApp({this.isDark, required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) =>AppCubit()),
        BlocProvider(create:(context)
        => ShopCubit()
          ..getHomeData()
          ..getCategoryData()
          ..getFavoriteData()
          ..getProfileData()
          ..getCartData()
          ..getAddresses()
          ..getFAQsData()
        ),
      ],
          child: BlocConsumer<AppCubit,ShopStates>(
          listener:(context,state){},
          builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
            return MaterialApp(
              title: 'Go Shop',
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                  splash: SplashScreen(),
                  nextScreen: startWidget,
                splashIconSize: 700,
                backgroundColor: Colors.deepPurple,
                animationDuration: Duration(milliseconds: 2000),
                splashTransition: SplashTransition.fadeTransition,
              ),
              theme: lightMode(),
              darkTheme: darkMode(),
              themeMode: cubit.appMode,
              );
  }
  )
    );
  }
}