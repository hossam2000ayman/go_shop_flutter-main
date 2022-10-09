import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goshop/modules/LoginScreen.dart';
import 'package:goshop/modules/zoom_drawer.dart';

import '../cubit/shopCubit.dart';
import '../cubit/signInCubit.dart';
import '../cubit/states.dart';
import '../remoteNetwork/cacheHelper.dart';
import '../shared/constants.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, ShopStates>(listener: (context, state) {
        if (state is SignUpSuccessState) if (state.signUpUserModel.status) {
          CacheHelper.saveData(
            key: 'token',
            value: state.signUpUserModel.data?.token,
          ).then((value) {
            token = state.signUpUserModel.data?.token;
            name.clear();
            phone.clear();
            email.clear();
            password.clear();
            confirmPassword.clear();
            navigateAndKill(context, ZDrawer());
            ShopCubit.get(context).currentIndex = 0;
            ShopCubit.get(context).getHomeData();
            ShopCubit.get(context).getProfileData();
            ShopCubit.get(context).getFavoriteData();
            ShopCubit.get(context).getCartData();
            ShopCubit.get(context).getAddresses();
          });
        } else
          showToast(state.signUpUserModel.message);
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: signUpFormKey,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          Text('O Shop',
                              style: TextStyle(
                                  fontSize:
                                      35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateAndKill(context, LoginScreen());
                              },
                              icon: Icon(Icons.close, color: Colors.white)),
                        ],
                      ),
                      Text(
                        'Create a Go Shop account',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.amber[700],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: name,
                    cursorColor: Colors.amber,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'like : Ahmed Reda',
                      label: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.amber,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Name field is required';
                      return null;
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phone,
                          cursorColor: Colors.amber,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Phone',
                            label: Text(
                              'Phone',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.amber,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Phone field is required';
                            return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          cursorColor: Colors.amber,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'example@gmail.com',
                            label: Text(
                              'E-mail',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.amber,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Email Address must be filled';
                            else if (!RegExp(
                                r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                .hasMatch(value))
                              return 'Email Address is not valid';
                            else
                              return null;
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        cursorColor: Colors.amber,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: '******',
                          label: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              SignInCubit.get(context).suffixIcon,
                            ),
                            onPressed: () {
                              SignInCubit.get(context).changeSuffixIcon(context);
                            },
                            color: !SignInCubit.get(context).showPassword
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                        obscureText: !SignInCubit.get(context).showPassword
                            ? true
                            : false,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Password must be filled';
                          else if (value.length < 6)
                            return 'Password must be at least 6 characters';
                          else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value))
                            return 'Password must contain at \nleast one uppercase,\none lowercase,\none number and\none special character like !@#\$&*~';
                          return null;
                        },
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPassword,
                        cursorColor: Colors.amber,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: '******',
                          label: Text(
                            'Confirm Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              SignInCubit.get(context).suffixIcon,
                            ),
                            onPressed: () {
                              SignInCubit.get(context).changeSuffixIcon(context);
                            },
                            color: !SignInCubit.get(context).showPassword
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                        obscureText: !SignInCubit.get(context).showPassword
                            ? true
                            : false,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Password must be filled';
                          else if (value.length < 6)
                            return 'Password must be at least 6 characters';
                          else if (value != password.text)
                            return 'Password does not match';
                          else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value))
                            return 'Password must contain at \nleast one uppercase,\none lowercase,\none number and\none special character like !@#\$&*~';
                          return null;
                        },
                        onFieldSubmitted: (value) {},
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      state is SignUpLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : TextButton(
                              onPressed: () {
                                if(signUpFormKey.currentState!.validate())
                                {
                                  SignInCubit.get(context).signUp(
                                      name: name.text,
                                      phone: phone.text,
                                      email: email.text,
                                      password: password.text
                                  );
                                }
                                token =
                                    CacheHelper.getData('token');
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.amber[700],
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
