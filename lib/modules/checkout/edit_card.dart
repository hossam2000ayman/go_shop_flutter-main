import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';



class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  var nameCardController = TextEditingController();
  var cardNumberController = TextEditingController();
  var expiryDateController = TextEditingController();
  var cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Order History',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
          ),
          // actions: [
          //   AppIcons(iconSource: "assets/images/home.svg",
          //       press:() {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => ZoomDrawers()));
          //       }
          //   )
          //
          // ],
          // leading : AppIcons(iconSource: "assets/images/menu.svg",
          //     press:() {
          //       ZoomDrawer.of(context)!.toggle();
          //     }
          // )
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CreditCard(
                  cardNumber: cardNumber,
                  cardExpiry: expiryDate,
                  cardHolderName: cardHolderName,
                  cvv:  cvv,
                  bankName: "Axis Bank",
                  showBackSide: false,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.white,
                  showShadow: true,
                  textExpDate: 'Exp. Date',
                  textName: cardHolderName,
                  textExpiry: 'MM/YY'
              ),
              paymentCard(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  const [
                    Icon(Icons.check_circle,
                      color: Color(0xffE99000),
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Save this Card details',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: (){
                      },
                      autofocus: true,
                      style: OutlinedButton.styleFrom(
                          primary: const Color(0xffE9BC6B),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50
                            )
                            ),
                          ),
                          shadowColor: Colors.red
                      ),
                      child: const Text('Back',
                        style: TextStyle(
                            fontSize: 20
                        ),
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
                      onPressed: (){
                      },
                      autofocus: true,
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color(0xffE99000),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50
                            ))
                        ),
                      ),
                      child:  const Text('Next',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvv = creditCardModel.cvvCode;
    });
  }
  Widget paymentCard() {
    return CreditCardForm(
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvvCode: cvv,
      formKey: formKey,
      themeColor: Colors.black87,
      cardNumber: cardNumber,
      onCreditCardModelChange: onCreditCardModelChange
    );
  }
}
