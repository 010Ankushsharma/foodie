import 'dart:convert';

import 'package:flutter/material.dart';
class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
 // Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text('Wallet',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/wallet.jpeg",
                      height: 60, width: 60, fit: BoxFit.cover),
                  SizedBox(
                    width: 40.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your wallet',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                      SizedBox(height: 5.0,),
                      Text('₹ 0.00',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Add money',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE9E9E9),),
                    borderRadius: BorderRadius.circular(5.0),

                  ),
                  child: Text('₹'+' 100',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE9E9E9),),
                    borderRadius: BorderRadius.circular(5.0),

                  ),
                  child: Text('₹'+' 500',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE9E9E9),),
                    borderRadius: BorderRadius.circular(5.0),

                  ),
                  child: Text('₹'+' 1000',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE9E9E9),),
                    borderRadius: BorderRadius.circular(5.0),

                  ),
                  child: Text('₹'+' 2000',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100),),
                )
              ]
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF008080),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text('Add money',style: TextStyle(color:Colors.white,fontSize: 14.0,fontWeight: FontWeight.bold),),
              ),
            )

          ],
        ),
      ),
    );
  }
  // Future <void>makePayment(String amount) async {
  //   // TODO: implement makePayment
  //   try{
  //     paymentIntent = await createPaymentIntent(amount, 'INR');
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentIntent!['client_secret'],
  //           style: ThemeMode.dark,
  //           merchantDisplayName: 'Food Delivery App',
  //           // customerId: paymentIntent!['customer'],
  //           // customerEphemeralKeySecret: paymentIntent!['ephemeral_key'],
  //         )
  //     ).then((value) => {});
  //     displayPaymentSheet(amount);
  //   }catch(e,s){
  //     print("exception:${e.toString()}");
  //
  //   }
  // }
  //
  // displayPaymentSheet(String amount) async {
  //   try{
  //     await Stripe.instance.presentPaymentSheet().then((value) => {
  //       showDialog(context: context, builder: (_)=>AlertDialog(
  //         content: Column(
  //           children: [
  //             Icon(Icons.check_circle,color: Colors.green,size: 50,),
  //             Text('Payment successfully')
  //           ],
  //         ),
  //       )),
  //      // await usergetprofile(),
  //       paymentIntent = null,
  //     }).onError((error, stackTrace)=> {
  //      // print('Error is: $error $stackTrace'),
  //      // print('Error is: $error $stackTrace');
  //     });
  //
  //   }on StripeException catch(e){
  //       print("exception error :$e");
  //       showDialog(context: context, builder: (_)=>AlertDialog(
  //   content: Text('Cancelled payment'),
  //   ));
  //
  //     }catch(e){
  //       print("exception error :$e");
  //   }
  //
  //     }
  //     createPaymentIntent(String amount, String currency) async {
  //       try{
  //         Map<String, dynamic> body = {
  //           'amount': calculateAmount(amount),
  //           'currency': currency,
  //           'payment_method_types[]': 'card',
  //         };
  //         var response = await http.post(
  //             Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //             body: body,
  //             headers: {
  //               'Authorization': 'Bearer ${secretkey}',
  //               'Content-Type': 'application/x-www-form-urlencoded'
  //             }
  //         );
  //         print('payment intent body ${response.body.toString()}');
  //         return jsonDecode(response.body);
  //       }catch(err){
  //         print('err charging user: ${err.toString()}');
  //       }
  //       }
  //
  //       calculateAmount(String amount) {
  //         final calculatedAmount = (int.parse(amount)) * 100;
  //         return calculatedAmount.toString();
  //     }
    }

