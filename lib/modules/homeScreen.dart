import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:goshop/modules/productScreen.dart';
import 'package:goshop/modules/zoom_drawer.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../models/categoriesModels/categoriesModel.dart';
import '../models/homeModels/homeModel.dart';
import '../shared/constants.dart';
import 'CategoriesScreen.dart';
import 'SearchScreen.dart';
import 'categoryProductsScreen.dart';

class HomeScreen extends StatelessWidget {
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is HomeSuccessState)
        cartLength = ShopCubit.get(context).cartModel.data!.cartItems.length;
      if (state is ChangeFavoritesSuccessState) {
        if (state.model.status == false)
          showToast(state.model.message);
        else
          showToast(state.model.message);
      }
    }, builder: (context, state) {
      ShopCubit cubit = ShopCubit.get(context);
      return Conditional.single(
        context: context,
        conditionBuilder: (context) => cubit.homeModel != null,
        widgetBuilder: (context) =>
            productBuilder(cubit.homeModel, cubit.categoriesModel, context),
        fallbackBuilder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget productBuilder(
      HomeModel? homeModel, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.deepPurple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_list,
                            color: Colors.white),
                        onPressed: () {
                          ZoomDrawer.of(context)!.toggle();
                        },
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.white),
                        onPressed: () {
                          navigateTo(context, ZDrawer());
                          ShopCubit.get(context).currentIndex = 2;
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              navigateTo(
                                context,
                                SearchScreen(
                                  ShopCubit.get(context),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.deepPurple,
                            ),
                            label: const Text(
                              'Type a product name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Comming soon ...'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.deepPurple,
                              size: 30.0,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context, CategoriesScreen());
                  },
                  child:
                      Text('See all (${categoriesModel!.data!.data.length})'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 160,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => categoriesAvatar(
                  categoriesModel.data!.data[index], context),
              separatorBuilder: (context, index) => SizedBox(
                width: 18,
              ),
              itemCount: categoriesModel.data!.data.length,
            ),
          ),
          CarouselSlider(
            items: homeModel!.data!.banners
                .map((e) => Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(seconds: 1),
              enableInfiniteScroll: true,
              height: 200,
              initialPage: 0,
              reverse: false,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.9,
            ),
            carouselController: carouselController,
          ),
          Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(15),
              child: Text(
                'Hot Deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          separator(0, 1),
          StaggeredGrid.count(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 8.0,
            crossAxisCount: 2,
            children: List.generate(
              homeModel.data!.products.length,
              (index) => productItemBuilder(
                  homeModel.data!.products[index], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget productItemBuilder(HomeProductModel model, context) {
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

  Widget categoriesAvatar(DataModel model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsScreen(model.name));
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                    image: DecorationImage(
                        image: NetworkImage('${model.image}'),
                        fit: BoxFit.cover)),
              ),
              Container(
                color: Colors.white.withOpacity(0.5),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: Text(
                    '${model.name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
