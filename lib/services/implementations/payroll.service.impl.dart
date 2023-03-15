import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/data_models/payroll.data.dart';
import 'package:flex_year_tablet/helper/api_error.helper.dart';
import 'package:flex_year_tablet/helper/api_response.helper.dart';
import 'package:flex_year_tablet/services/app_access.service.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/payroll.service.dart';

import '../../ui/personal/dashboard/dashboard.model.dart';

class PayrollServiceImpl implements PayrollService {
  final ApiService _apiService = locator<ApiService>();
  final AppAccessService _appAccessService = locator<AppAccessService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final _user = locator<DashboardModel>().user;

  @override
  Future<List<PayrollData>> getAllPayrolls({
    required Map<String, dynamic> data,
  }) async {
    try {
      final _response = await _apiService.post(auPayrollHistory, {
        'access_token': _authenticationService.user!.accessToken,
        'company_id': _appAccessService.appAccess!.company.companyId,
        'limit': 15,
        'page': 1,
        'sortnane': "start_date",
        'sortno': 1,
        'search': {"staff_id": _authenticationService.user!.id, ...data}
      });
      final _data = constructResponse(_response.data);
      if (_data!.containsKey("status") && _data["status"] == false) {
        throw _data["response"] ?? _data["detail"] ?? _data["data"];
      }
      {
        return (_data['data'] as List<dynamic>)
            .map<PayrollData>((e) => PayrollData.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw apiError(e);
    }
  }

  @override
  Future<void> actionOnPayroll(
      {required String payrollid, required String action}) {
    // TODO: implement actionOnPayroll
    throw UnimplementedError();
  }
}
