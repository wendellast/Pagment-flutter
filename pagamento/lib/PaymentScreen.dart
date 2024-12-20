import 'package:flutter/material.dart';
import 'package:pagamento/StripService.dart';

class Paymentscreen extends StatefulWidget {
  const Paymentscreen({super.key});

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  String amount = "5000";
  String currency = "USD";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
        ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(onPressed: ()async {
              try{
                await StripeService.initPaymentSheet(amount, currency);
                await StripeService.presentPaymentSheet();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erro ${e.toString()}"),),);
              }
             }, 
            child:  Text("Pagar \$50 }" )),
          ],
        )
      )
    );
  }
}