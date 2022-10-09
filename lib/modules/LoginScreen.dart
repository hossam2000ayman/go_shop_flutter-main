import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goshop/modules/registerScreen.dart';
import 'package:goshop/modules/zoom_drawer.dart';

import '../cubit/LoginCubit.dart';
import '../cubit/shopCubit.dart';
import '../cubit/states.dart';
import '../remoteNetwork/cacheHelper.dart';
import '../shared/constants.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
var loginFormKey = GlobalKey<FormState>();
bool hidePassword = true;

class LoginScreen extends StatelessWidget {
  get obscureText => null;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ShopStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginUserModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginUserModel.data!.token)
                  .then((value) {
                token = state.loginUserModel.data!.token;
                navigateAndKill(context, ZDrawer());
                emailController.clear();
                passwordController.clear();
                ShopCubit.get(context).currentIndex = 0;
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getProfileData();
                ShopCubit.get(context).getFavoriteData();
                ShopCubit.get(context).getCartData();
                ShopCubit.get(context).getAddresses();
              });
            } else
              showToast(state.loginUserModel.message);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: loginFormKey,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
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
                            controller: passwordController,
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
                                  LoginCubit.get(context).suffixIcon,
                                ),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changeSuffixIcon(context);
                                },
                                color: !LoginCubit.get(context).showPassword
                                    ? Colors.amber
                                    : Colors.white,
                              ),
                            ),
                            obscureText: !LoginCubit.get(context).showPassword
                                ? true
                                : false,
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Password must be filled';
                              else if (value.length < 6)
                                return 'Password must be at least 6 characters';
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (loginFormKey.currentState!.validate()) {
                                LoginCubit.get(context).signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          Container(
                            width: double.infinity,
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forget Password ?',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            children: [
                              state is LoginLoadingState
                                  ? Center(child: CircularProgressIndicator())
                                  : Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            LoginCubit.get(context).signIn(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                            token =
                                                CacheHelper.getData('token');
                                          }
                                        },
                                        child: Text(
                                          'Log in',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                              Text(
                                  '|',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
