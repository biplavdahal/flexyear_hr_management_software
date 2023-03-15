import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';

class RequestReviewArguments<T> extends Arguments {
  final RequestReviewType type;
  final T? payload;

  RequestReviewArguments({required this.type, this.payload});
}
