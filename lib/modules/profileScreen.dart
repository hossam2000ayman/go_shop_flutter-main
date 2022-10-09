import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../shared/component.dart';
import '../shared/constants.dart';
import 'changePasswordScreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) if (state
            .updateUserModel.status)
          showToast(state.updateUserModel.message);
        else
          showToast(state.updateUserModel.message);
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var model = cubit.userModel;
        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        emailController.text = model.data!.email!;

        return Scaffold(
          backgroundColor: Colors.deepPurple,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
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
                    Text(
                      '${cubit.userModel!.data!.name!}',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${cubit.userModel!.data!.email}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (state is UpdateProfileLoadingState)
                                    Column(
                                      children: [
                                        LinearProgressIndicator(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        'PERSONAL INFORMATION',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              editPressed(
                                                context: context,
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: emailController.text,
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '$editText',
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: defaultFormField(
                                        controller: nameController,
                                        context: context,
                                        prefix: Icons.person,
                                        isContainer: true,
                                        label: 'Name',
                                        radius: 10,
                                        prefixColor: Colors.deepPurple,
                                        enabled: isEdit ? true : false,
                                        validate: (value) {
                                          return null;
                                        }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: defaultFormField(
                                        context: context,
                                        controller: emailController,
                                        prefix: Icons.mail,
                                        isContainer: true,
                                        label: 'Email',
                                        radius: 10,
                                        prefixColor: Colors.deepPurple,
                                        enabled: isEdit ? true : false,
                                        validate: (value) {
                                          if(value!.isEmpty)
                                            return 'Email Address must be filled';
                                          else if(!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value))
                                            return 'Email Address is not valid';
                                          else return null;
                                        }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: defaultFormField(
                                        context: context,
                                        controller: phoneController,
                                        prefix: Icons.phone,
                                        isContainer: true,
                                        label: 'Phone',
                                        radius: 10,
                                        prefixColor: Colors.deepPurple,
                                        enabled: isEdit ? true : false,
                                        validate: (value) {
                                          if(value!.isEmpty)
                                            return 'Phone Number must be filled';
                                          else if(!RegExp(r'^[0-9]{11}').hasMatch(value))
                                            return 'Phone Number is not valid';
                                          else return null;
                                        }),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SECURITY INFORMATION',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            navigateTo(
                                                context, ChangePasswordScreen());
                                          },
                                          child: Text(
                                            'Change Password',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
