  import 'package:flex_year_tablet/data_models/birthday.data.dart';

abstract class BirthdayService{
  ///Getter for all birthday list
  List<BirthdayData> get birthdays;

  ///Set birthday List
  set birthdays(List<BirthdayData> value);

  /// Get company birthday
  Future<List<BirthdayData>> getBirthday();
}