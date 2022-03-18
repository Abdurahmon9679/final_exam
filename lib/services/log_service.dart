import 'package:benaficary/services/http_service.dart';
import 'package:logger/logger.dart';



class Log{
  static  final Logger _logger = Logger(
    printer:PrettyPrinter(),
  );

  static void d(String messege){
    if(Network.isTester) _logger.d(messege);
  }

  static void i(String messege){
    if(Network.isTester)  _logger.d(messege);
  }

  static void w(String messege){
    if(Network.isTester) _logger.d(messege);
  }

  static void e(String messege){
    if(Network.isTester) _logger.d(messege);
  }
}