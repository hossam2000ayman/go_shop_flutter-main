import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../models/addressModels/addressModel.dart';
import '../shared/constants.dart';
import 'SearchScreen.dart';
import 'add&UpdateAddress.dart';

class AddressesScreen extends StatelessWidget {
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                Text(
                  'O Shop',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.amber[700]),
              onPressed: () {
                pop(context);
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen(ShopCubit.get(context)));
                  },
                  icon: Icon(Icons.search, color: Colors.amber[700])),
            ],
          ),
          bottomSheet: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: TextButton(
              onPressed: () {
                navigateTo(
                    context,
                    UpdateAddressScreen(
                      isEdit: false,
                    ));
              },
              //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              child: Text(
                'ADD A NEW ADDRESS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ShopCubit.get(context)
                        .addressModel
                        .data!
                        .data!
                        .length == 0
                        ? Container()
                        : addressItem(
                      ShopCubit.get(context)
                          .addressModel
                          .data!
                          .data![index],
                      context,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    itemCount: ShopCubit.get(context)
                        .addressModel
                        .data!
                        .data!
                        .length),
                Container(
                  color: Colors.white,
                  height: 70,
                  width: double.infinity,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addressItem(AddressData model, context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: Colors.deepPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.deepPurple,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${model.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      ShopCubit.get(context).deleteAddress(addressId: model.id);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 17,
                        ),
                        Text('Delete')
                      ],
                    )),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey[300],
                ),
                TextButton(
                    onPressed: () {
                      navigateTo(
                          context,
                          UpdateAddressScreen(
                            isEdit: true,
                            addressId: model.id,
                            name: model.name,
                            city: model.city,
                            region: model.region,
                            details: model.details,
                            notes: model.notes,
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 17,
                          color: Colors.grey,
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Divider(
            color: Colors.amber[300],
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Region',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Notes',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${model.city}',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text('${model.region}',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text('${model.details}',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text('${model.notes}',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      //
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
