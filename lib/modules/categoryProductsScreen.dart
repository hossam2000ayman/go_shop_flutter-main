import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goshop/modules/productScreen.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../models/categoriesModels/categoriesDetailsModel.dart';
import '../shared/constants.dart';
import 'SearchScreen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;
  CategoryProductsScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              titleSpacing: 0,
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Text('O Shop',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.amber[700],),
                onPressed: () {
                  pop(context);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(
                        ShopCubit.get(context),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.amber[700],
                  ),
                ),
              ],
            ),
            body: state is CategoryDetailsLoadingState ?
            Center(child: CircularProgressIndicator(),) :  ShopCubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
            Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(15),
                        child: Text('$categoryName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                    ),
                    separator(0, 1),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        ShopCubit.get(context).categoriesDetailModel!.data.productData.length,
                            (index) => ShopCubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
                               Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
                               productItemBuilder(ShopCubit.get(context).categoriesDetailModel!.data.productData[index],context)
                            ),
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.73,
                    mainAxisSpacing: 5,
                  ),
                ],
                ),
            ),
          );
        },
      );
  }

  Widget productItemBuilder (ProductData model,context) {
    return InkWell(
      onTap: (){
        ShopCubit.get(context).getProductData(model.id);
        navigateTo(context, ProductScreen());
        },
      child: Card(
        elevation: 5,
        shadowColor: Colors.deepPurple,
        margin: EdgeInsets.all(5),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Stack(
                  alignment:AlignmentDirectional.bottomStart,
                  children:[
                    Image(image: NetworkImage('${model.image}'),height: 150,width: 150,),
                    if(model.discount != 0 )
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topLeft: Radius.circular(5))),
                          child: Text('${model.discount}'+'% OFF',style: TextStyle(color: Colors.white,fontSize: 12),)
                      )
                  ]),
              separator(0,10),
              Text('${model.name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
              Spacer(),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                            Text('${model.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),
                          ],
                        ),
                        separator(0, 2),
                        if(model.discount != 0 )
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                              Text('${model.oldPrice}',
                                style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                      ]
                  ),
                  // IconButton(
                  //   onPressed: ()
                  //   {
                  //     ShopCubit.get(context).changeToFavorite(model.id);
                  //     print(model.id);
                  //   },
                  //   icon: Conditional.single(
                  //     context: context,
                  //     conditionBuilder:(context) => ShopCubit.get(context).favorites[model.id],
                  //     widgetBuilder:(context) => ShopCubit.get(context).favoriteIcon,
                  //     fallbackBuilder: (context) => ShopCubit.get(context).unFavoriteIcon,
                  //   ),
                  //   padding: EdgeInsets.all(0),
                  //   iconSize: 20,
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
