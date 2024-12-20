import 'package:flutter/material.dart';
import 'package:pagamento/PaymentScreen.dart';
import 'package:pagamento/StripService.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  StripeService.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Paymentscreen(),
    );
  }

}