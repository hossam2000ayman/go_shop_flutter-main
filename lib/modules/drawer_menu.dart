import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';

class DrawerMenu extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerMenu({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
      ShopCubit cubit = ShopCubit.get(context);
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.account_circle,
                    size: 100.0,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
               Text(
                '${cubit.userModel?.data!.name!}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
               Text(
                '${cubit.userModel?.data!.email}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(children: [
                drawerMenuItem(Icons.home, 'Home', 0),
                drawerMenuItem(Icons.favorite, 'Wishlist', 1),
                drawerMenuItem(Icons.shopping_cart, 'Cart', 2),
                drawerMenuItem(Icons.person, 'Profile', 3),
                drawerMenuItem(Icons.settings, 'Settings', 4),
                drawerMenuItem(Icons.question_mark, 'Help & FAQs', 5),
              ]),
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.output_rounded,
                  color: Colors.amber,
                ),
                minLeadingWidth: 0.0,
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  signOut(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget drawerMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.amber,
      ),
      minLeadingWidth: 0.0,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onTap: () {
        widget.setIndex(index);
      },
    );
  }
}
