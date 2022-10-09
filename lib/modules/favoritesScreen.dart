import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:goshop/modules/productScreen.dart';
import 'package:goshop/modules/zoom_drawer.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../models/favoritesModels/favoritesModel.dart';
import '../shared/constants.dart';
import 'SearchScreen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Conditional.single(
              context: context,
              conditionBuilder: (context) => state is! FavoritesLoadingState,
              widgetBuilder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Colors.deepPurple,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.menu, color: Colors.white),
                                onPressed: () {
                                  ZoomDrawer.of(context)!.toggle();
                                },
                              ),
                              const Text(
                                'Wishlist',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.home_outlined,
                                    color: Colors.white),
                                onPressed: () {
                                  navigateAndKill(context, ZDrawer());
                                  ShopCubit.get(context).currentIndex = 0;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                'My Wishlist',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${ShopCubit.get(context).favoritesModel!.data.total} items)',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeListView();
                                },
                                icon: Icon(
                                  Icons.list_alt,
                                  color: Colors.amber[700],
                                ),
                                splashRadius: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeGridView();
                                },
                                icon: Icon(
                                  Icons.grid_view_rounded,
                                  color: Colors.deepPurple,
                                ),
                                splashRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        ShopCubit.get(context).isList ?
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => favoriteProducts(
                                ShopCubit.get(context)
                                    .favoritesModel!
                                    .data
                                    .data[index]
                                    .product,
                                context),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: ShopCubit.get(context)
                                .favoritesModel!
                                .data
                                .data
                                .length,
                        ) :
                        StaggeredGrid.count(
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 8.0,
                          crossAxisCount: 2,
                          children: List.generate(
                              ShopCubit.get(context)
                                  .favoritesModel!
                                  .data
                                  .data
                                  .length,
                                  (index) => productItemBuilder(
                                      ShopCubit.get(context)
                                          .favoritesModel!
                                          .data
                                          .data[index]
                                          .product!,
                                      context),
                          ),
                        ),
                      ],
                    ),
                  ),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator())),
        );
      },
    );
  }

  Widget favoriteProducts(FavoriteProduct? model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model!.id);
        navigateTo(context, ProductScreen());
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.14,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      children: [
                        Image(
                          image: NetworkImage('${model!.image}'),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Text(
                                'EGP ' + '${model.price}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.005,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.amber[700],
                ),
                onPressed: () {
                  ShopCubit.get(context).changeToFavorite(model.id);
                  ShopCubit.get(context).getFavoriteData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget productItemBuilder(FavoriteProduct model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model.id);
        navigateTo(context, ProductScreen());
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Stack(
          children: [
            Card(
              elevation: 3.0,
              shadowColor: Colors.deepPurple,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image(
                image: NetworkImage(model.image!),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.008,
              right: MediaQuery.of(context).size.width * 0.02,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.6),
                child: IconButton(
                  splashRadius: 10,
                  onPressed: () {
                    ShopCubit.get(context).changeToFavorite(model.id);
                  },
                  icon: Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                    ShopCubit.get(context).favorites[model.id],
                    widgetBuilder: (context) =>
                    ShopCubit.get(context).favoriteIcon,
                    fallbackBuilder: (context) =>
                    ShopCubit.get(context).unFavoriteIcon,
                  ),
                  padding: EdgeInsets.all(0),
                  iconSize: 20,
                ),
              ),
            ),
            if (model.discount != 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.008,
                left: MediaQuery.of(context).size.width * 0.03,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white70.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    '${model.discount}% OFF',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.035,
              bottom: MediaQuery.of(context).size.height * 0.001,
              child: Card(
                elevation: 3.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${model.name}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        color: Colors.deepPurple,
                        child: InkWell(
                          onTap: () {
                            ShopCubit.get(context).addToCart(model.id);
                            showToast('Added to cart');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text(
                                '${model.price} L.E',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (model.discount != 0)
                                Text(
                                  '${model.oldPrice} L.E',
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
