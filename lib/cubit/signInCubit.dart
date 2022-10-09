import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goshop/cubit/states.dart';

import '../models/profileModels/userModel.dart';
import '../remoteNetwork/dioHelper.dart';
import '../remoteNetwork/endPoints.dart';
import '../shared/constants.dart';


class SignInCubit extends Cubit<ShopStates>
{
  SignInCubit() : super(InitialState());

  static SignInCubit get(context) => BlocProvider.of(context);

  late UserModel signInModel;

  void signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(
        url: SIGNUP,
        token: token,
        data:
        {
          'name': '$name',
          'email': '$email',
          'phone': '$phone',
          'password': '$password',
        }).then((value) {
      signInModel = UserModel.fromJson(value.data);
      emit(SignUpSuccessState(signInModel));
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState());
    });
  }

  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword)
      suffixIcon = Icons.visibility;
    else
      suffixIcon = Icons.visibility_off;
    emit(ChangeSuffixIconState());
  }

  bool showConfirmPassword = false;
  IconData confirmSuffixIcon = Icons.visibility;
  void changeConfirmSuffixIcon(context){
    showConfirmPassword =! showConfirmPassword;
    if(showConfirmPassword)
      confirmSuffixIcon = Icons.visibility_off;
    else
      confirmSuffixIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

}