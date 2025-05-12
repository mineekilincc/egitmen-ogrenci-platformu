import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  Future<void> makePayment(BuildContext context) async {
    try {
      // 1. Backend'den PaymentIntent iste
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:5000/create-payment-intent',
        ), // Android emulator'da localhost
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'amount': 29900}), // 299 TL → Stripe kuruş ister
      );

      final data = json.decode(response.body);
      final clientSecret = data['clientSecret'];

      // 2. Ödeme sayfasını başlat
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.light,
          merchantDisplayName: 'Gastrovia',
        ),
      );

      // 3. Ödeme sayfasını göster
      await Stripe.instance.presentPaymentSheet();

      // 4. Başarılıysa kullanıcıya bilgi ver
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("✅ Başarılı"),
              content: const Text("Ödeme başarıyla tamamlandı."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tamam"),
                ),
              ],
            ),
      );
    } catch (e) {
      // ignore: avoid_print
      print("Stripe ödeme hatası: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ödeme başarısız: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stripe Ödeme")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => makePayment(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text("Satın Al (299₺)"),
        ),
      ),
    );
  }
}
