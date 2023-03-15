import 'dart:convert';

Map<String, dynamic>? constructResponse(dynamic data) {
  Map<String, dynamic>? constructedResponse;

  if (data is String) {
    constructedResponse = jsonDecode(data);
  } else if (data is Map) {
    constructedResponse = data as Map<String, dynamic>;
  }

  return constructedResponse;
}
