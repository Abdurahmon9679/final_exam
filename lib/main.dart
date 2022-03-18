import 'package:benaficary/pages/beneficiary_page.dart';
import 'package:benaficary/pages/recipients_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'services/hive_service.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const BeneficiaryPage(),
      routes: {
        BeneficiaryPage.id:(context)=>const BeneficiaryPage(),
        RecipientsPage.id:(context)=>const RecipientsPage(),
      },
    );
  }
}
