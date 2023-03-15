import 'package:flex_year_tablet/data_models/app_access.data.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';

abstract class AppAccessService {
  AppAccessData? get appAccess;

  String? get appUsage;
  set appUsage(String? value);

  ClientData? get client;

  String? get apiKey;

  Future<void> init();

  Future<void> getAppAccess(String token);

  Future<void> getClientAccess(String code);

  Future<void> clearData();
}
