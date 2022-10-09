import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';

class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  UpdateAddressScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameControl = TextEditingController();
    TextEditingController cityControl = TextEditingController();
    TextEditingController regionControl = TextEditingController();
    TextEditingController detailsControl = TextEditingController();
    TextEditingController notesControl = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is UpdateAddressSuccessState) {
          if (state.updateAddressModel.status) pop(context);
        } else if (state is AddAddressSuccessState) if (state
            .addAddressModel.status) pop(context);
      },
      builder: (context, state) {
        if (isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Text('O Shop',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  pop(context);
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.amber[700]),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is AddAddressLoadingState ||
                          state is UpdateAddressLoadingState)
                        Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      Text(
                        'LOCATION INFORMATION',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[700]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[700],
                        ),
                      ),
                      TextFormField(
                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please enter your Location name',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[700]!),
                            ),
                          ),
                          cursorColor: Colors.amber[700],
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'This field can\'t be Empty';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'City',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[700],
                        ),
                      ),
                      TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please enter your City name',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[700]!),
                            ),
                          ),
                          cursorColor: Colors.amber[700],
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'This field can\'t be Empty';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'Region',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[700],
                        ),
                      ),
                      TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please enter your region',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[700]!),
                            ),
                          ),
                          cursorColor: Colors.amber[700],
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'This field can\'t be Empty';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[700],
                        ),
                      ),
                      TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please enter some details',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[700]!),
                            ),
                          ),
                          cursorColor: Colors.amber[700],
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'This field can\'t be Empty';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.amber[700],
                        ),
                      ),
                      TextFormField(
                          controller: notesControl,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please add some notes to help find you',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 17),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[700]!),
                            ),
                          ),
                          cursorColor: Colors.amber[700],
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'This field can\'t be Empty';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              if (addressFormKey.currentState!.validate()) {
                                if (isEdit) {
                                  ShopCubit.get(context).updateAddress(
                                      addressId: addressId,
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text);
                                } else {
                                  ShopCubit.get(context).addAddress(
                                      name: nameControl.text,
                                      city: cityControl.text,
                                      region: regionControl.text,
                                      details: detailsControl.text,
                                      notes: notesControl.text);
                                }
                              }
                            },
                            child: Text(
                              'SAVE ADDRESS',
                              style: TextStyle(
                                color: Colors.amber[700],
                                fontSize: 20,
                              ),
                            )),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
