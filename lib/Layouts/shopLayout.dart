import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:goshop/modules/cartScreen.dart';
import 'package:goshop/modules/homeScreen.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../modules/SearchScreen.dart';
import '../shared/constants.dart';



class ShopLayout extends StatelessWidget {
  bool showBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {
        if(state is HomeSuccessState)
          int cartLen = ShopCubit.get(context).cartModel.data!.cartItems.length;
      },
      builder: (context,state) {
        ShopCubit cubit =  ShopCubit.get(context);
        return  Scaffold(
          bottomSheet: showBottomSheet ?
          ShopCubit.get(context).cartModel.data!.cartItems.length!= 0 ? Container(
            width: double.infinity,
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
            child: ElevatedButton(
              onPressed: (){},
              //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              child: Text('Check Out',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            ),
          )
              :Container(width: 0,height: 0,):Container(width: 0,height: 0,),
          body: HomeScreen(),
        );
      },
    );
  }
}
