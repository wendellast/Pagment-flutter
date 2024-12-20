import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = "$apiBase/payment_intents";
  static String secret = "sk_test_Ho24N7La5CVDtbmpjc377lJI";

  static Map<String, String> headers = {
    "Authorization": "Bearer $secret",
    "Content-Type": "application/x-www-form-urlencoded",
  };

  static void init() {
    Stripe.publishableKey = "pk_test_XKUpwPvvEnNxMsSzoLm8H3i8";
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse(paymentApiUrl),
        body: body,
        headers: headers,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception("Failed to create payment intent: $e");
    }
  }

  static Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      final paymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: "Dear Programmer",
          style: ThemeMode.system,
        ),
      );
    } catch (e) {
      throw Exception("Error initializing payment sheet: $e");
    }
  }

  static Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception("Error presenting payment sheet: $e");
    }
  }
}
