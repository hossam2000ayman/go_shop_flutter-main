import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              automaticallyImplyLeading: false,
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
            body: Container(
              color: Colors.white,
              width: double.infinity,
              //height: 280,
              child: Form(
                key: changePasskey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ChangePassLoadingState)
                      Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Password',
                            style: TextStyle(fontSize: 15),
                          ),
                          TextFormField(
                              controller: currentPass,
                              textCapitalization: TextCapitalization.words,
                              obscureText: !ShopCubit.get(context).showCurrentPassword
                                  ? true
                                  : false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: 'Please enter Current Password',
                                  hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 15),
                                  border: UnderlineInputBorder(),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        ShopCubit.get(context)
                                            .changeCurrentPassIcon(context);
                                      },
                                      icon: Icon(ShopCubit.get(context)
                                          .currentPasswordIcon))),
                              validator: (value) {
                                if (value!.isEmpty) return 'This field cant be Empty';
                                return null;
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'New Password',
                            style: TextStyle(fontSize: 15),
                          ),
                          TextFormField(
                              controller: newPass,
                              textCapitalization: TextCapitalization.words,
                              obscureText: !ShopCubit.get(context).showNewPassword
                                  ? true
                                  : false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: 'Please enter New Password',
                                  hintStyle:
                                      TextStyle(color: Colors.grey, fontSize: 15),
                                  border: UnderlineInputBorder(),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        ShopCubit.get(context)
                                            .changeNewPassIcon(context);
                                      },
                                      icon: Icon(
                                          ShopCubit.get(context).newPasswordIcon))),
                              validator: (value) {
                                if (value!.isEmpty) return 'This field cant be Empty';
                                return null;
                              }),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          if (changePasskey.currentState!.validate()) {
                            ShopCubit.get(context).changePassword(
                              context: context,
                              currentPass: currentPass.text,
                              newPass: newPass.text,
                            );
                          }
                        },
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.amber[700],
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
