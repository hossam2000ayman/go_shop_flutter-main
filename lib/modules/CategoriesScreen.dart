import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../models/categoriesModels/categoriesModel.dart';
import '../shared/constants.dart';
import 'categoryProductsScreen.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state)
      {
       return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            centerTitle: true,
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),
              child: Text('Categories',style: TextStyle(color: Colors.white),),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                pop(context);
              },
            ),
          ),
         body: ListView.separated(
             itemBuilder:(context,index) => buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
             separatorBuilder:(context,index) => myDivider(),
             itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length
         ),
       );
      } ,
    );
  }

  Widget buildCategoriesItem (DataModel model,context) {
    return
      InkWell(
          onTap: (){
            ShopCubit.get(context).getCategoriesDetailData(model.id);
            navigateTo(context, CategoryProductsScreen(model.name));
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children:
              [
                Image(image: NetworkImage('${model.image}'),width: 100,height: 100,fit: BoxFit.cover,),
                separator(15, 0),
                Text('${model.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Spacer(),
                Icon(Icons.arrow_forward_ios_rounded),
                separator(10,0),
              ],
            ),
          ),
        );
  }
}
