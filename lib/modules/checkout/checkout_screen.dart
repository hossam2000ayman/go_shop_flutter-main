import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:goshop/cubit/shopCubit.dart';
import 'package:goshop/cubit/states.dart';
import 'package:goshop/models/addressModels/addAddressModel.dart';
import 'package:goshop/modules/checkout/payment_screen.dart';
import 'package:goshop/shared/constants.dart';

import '../../models/addressModels/addressModel.dart';
import '../../models/cartModels/cartModel.dart';
import '../add&UpdateAddress.dart';
import '../productScreen.dart';
import 'edit_card.dart';

class CheckoutScreen extends StatelessWidget {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  var boardController = PageController();
  var street1Controller = TextEditingController();
  var street2Controller = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var expiryDateController = TextEditingController();
  var cardNumberController = TextEditingController();
  var cvvController = TextEditingController();

  List<StepperData> stepperData = [
    StepperData(
      title: "Address",
      subtitle: '',
    ),
    StepperData(
      title: "Payment",
      subtitle: "",
    ),
    StepperData(
      title: "Summary",
      subtitle: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder: (context,state)=>Scaffold(
        key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: const Text('Checkout',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                )),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new , color: Colors.white,),
              onPressed: () {
                pop(context);
              },
            ),
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            actions: [
              IconButton(icon: Icon(Icons.home_outlined,color: Colors.white,), onPressed: () {}),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.horizontal,
                horizontalStepperHeight: 60,
                inverted: true,
                activeIndex: ShopCubit.get(context).currentStep,
                gap: 50,
                activeBarColor: const Color(0xffE99000),
                inActiveBarColor: Colors.white,
                dotWidget: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color(0xffE99000),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
            ),
          ),
          body: PageView(
            onPageChanged: (index) {
              ShopCubit.get(context).currentStep = index;
              ShopCubit.get(context).changeStep(index);
            },
            controller: boardController,
            children: [
              address(context),
              payments(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: summary(context)),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:  [
                              Text(
                                "Total",
                                style: TextStyle(fontSize: 20, color: Color(0xff432267)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: Color(0xffE99000),
                              )
                            ],
                          ),
                           Text(
                            "${ShopCubit.get(context).cartModel.data!.total} L.E",
                            style: TextStyle(fontSize: 15, color: Color(0xff432267)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                            "Payment",
                            style: TextStyle(fontSize: 20, color: Color(0xff432267)),
                          ),
                          Row(
                            children: [
                              // Image.asset(
                              //   "assets/images/Icon_MasterCard.png",
                              //   width: size.width * 0.1,
                              //   height: size.height * 0.05,
                              // ),
                              Text(
                                "Paypal",
                                style: TextStyle(fontSize: 15, color: Color(0xff432267)),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xffE99000),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {
                                    boardController.previousPage(
                                        duration: const Duration(milliseconds: 2500),
                                        curve: Curves.fastLinearToSlowEaseIn);
                                    ShopCubit.get(context).changeStep(ShopCubit.get(context).currentStep - 1);
                                  },
                                  autofocus: true,
                                  style: OutlinedButton.styleFrom(
                                      primary: const Color(0xffE9BC6B),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                      ),
                                      shadowColor: Colors.red),
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Payment(
                                          onFinish: (number) async {
                                            // payment done
                                            final snackBar = SnackBar(
                                              content: Text("Payment done Successfully"),
                                              duration: Duration(seconds: 5),
                                              action: SnackBarAction(
                                                label: 'Close',
                                                onPressed: () {
                                                  // Some code to undo the change.
                                                },
                                              ),
                                            );
                                            _scaffoldKey.currentState?.showBottomSheet((context) => snackBar);
                                            print('order id: ' + number);
                                            print('ddasdas');
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  autofocus: true,
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: const Color(0xffE99000),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50))),
                                  ),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget card(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        height: 50,
        child: OutlinedButton(
          onPressed: () {
          },
          autofocus: true,
          style: OutlinedButton.styleFrom(
            primary: const Color(0xffE99000),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
          ),
          child: Icon(
            icon,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget address(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ShopCubit.get(context)
                      .addressModel
                      .data!
                      .data!
                      .length == 0
                      ?
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          UpdateAddressScreen(
                            isEdit: false,
                          ),
                      );
                    },
                    child:  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple[200]!,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        'Add New Address',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Color(0xffE99000)),
                      ),
                    ),
                  )
                      : ListView.separated(
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
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      pop(context);
                    },
                    autofocus: true,
                    style: OutlinedButton.styleFrom(
                        primary: const Color(0xffE9BC6B),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        shadowColor: Colors.red),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                SizedBox(
                  width: 120,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn);
                        ShopCubit.get(context).changeStep(1);
                    },
                    autofocus: true,
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color(0xffE99000),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget payments(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  card(Icons.paypal_outlined),
                  card(Icons.credit_card),
                  card(Icons.wallet),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Payment method available now is Paypal',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Icon(
                    Icons.paypal_outlined,
                    color: Color(0xffE99000),
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                        boardController.animateToPage(0,
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn);
                        ShopCubit.get(context).changeStep(0);
                    },
                    autofocus: true,
                    style: OutlinedButton.styleFrom(
                        primary: const Color(0xffE9BC6B),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        shadowColor: Colors.red),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                SizedBox(
                  width: 120,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn);
                        ShopCubit.get(context).changeStep(2);
                    },
                    autofocus: true,
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color(0xffE99000),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget summary(context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Summary",
              style: TextStyle(fontSize: 20, color: Color(0xff432267)),
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: cartProducts(
                    ShopCubit.get(context)
                        .cartModel
                        .data!
                        .cartItems[index],
                    context),
              ),
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: cartLength,
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentCard() {
    return CreditCardForm(
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvvCode: cvv,
      formKey: formKey,
      themeColor: Colors.black87,
      cardNumber: cardNumber,
      onCreditCardModelChange: onCreditCardModelChange,
    );
  }

  Widget textAdd(String t, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: c,
        validator: (String? txt) {
          if (txt!.isEmpty) {
            return 'please enter data';
          }
          return null;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: t,
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvv = creditCardModel.cvvCode;
  }

  Widget cartProducts(CartItems? model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model!.product!.id);
        navigateTo(context, ProductScreen());
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.99,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(model!.product!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.022,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.027,
                          ),
                          Text(
                            model.product!.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            'EGP ' + '${model.product!.price}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
                          overflow: TextOverflow.ellipsis,
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

