import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:goshop/cubit/shopCubit.dart';
import 'package:goshop/cubit/states.dart';

import 'drawer_menu.dart';



class ZDrawer extends StatefulWidget {
  const ZDrawer({Key? key}) : super(key: key);

  @override
  State<ZDrawer> createState() => _ZDrawerState();
}

class _ZDrawerState extends State<ZDrawer> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder:(context, states)=> ZoomDrawer(
        menuScreen: DrawerMenu(
          setIndex: (value) {
            ShopCubit.get(context).changeDrawerMenu(value);
          },
        ),
        mainScreen: ShopCubit.get(context).currentScreen(),
        angle: 0.0,
        showShadow: true,
        androidCloseOnBackTap: true,
        menuBackgroundColor: Colors.deepPurple,
        borderRadius: 50.0,
        shadowLayer1Color: Colors.deepPurple,
        shadowLayer2Color: Colors.white.withOpacity(0.3),
      ),
    );
  }

}
