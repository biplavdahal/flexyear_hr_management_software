import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/client.data.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.arguments.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.arguments.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.view.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

enum AttendanceReportFilterType {
  daily,
  weekly,
  monthly,
  oneDayReport,
}

class AttendanceReportFilterModel extends ViewModel
    with DialogMixin, SnackbarMixin {
  // Data
  late AttendanceReportFilterType _filterType;
  AttendanceReportFilterType? get filterType => _filterType;

  List<ClientData>? get clients =>
      locator<AuthenticationService>().user!.role?.toLowerCase() != 'staff'
          ? locator<CompanyService>().clients
          : locator<AuthenticationService>().user!.clients;

  List<String>? get clientsLabel => clients?.map((e) => e.name).toList();

  ClientData? _selectedClient;
  String? _selectedClientLabel;
  String? get selectedClientLabel => _selectedClientLabel;

  set selectedClientLabel(String? value) {
    _selectedClientLabel = value;
    _selectedClient = clients?.firstWhere((e) => e.name == value);
    setIdle();
  }

  bool _isNepaliDate = false;
  bool get isNepaliDate => _isNepaliDate;
  set isNepaliDate(bool value) {
    _isNepaliDate = value;
    setIdle();
  }

  //Nepali action
  NepaliDateTime? _nepaliDateFrom;
  NepaliDateTime? get nepaliDateFrom => _nepaliDateFrom;
  NepaliDateTime? _nepaliDateTo;
  NepaliDateTime? get nepaliDateTo => _nepaliDateTo;
  set nepaliDateFrom(NepaliDateTime? value) {
    _nepaliDateFrom = value;
    _nepaliDateTo = _nepaliDateFrom?.add(const Duration(days: 31));
    setIdle();
  }

  List<String> get nepaliMonths => [
        "बैशाख",
        "जेष्ठ",
        "आषाढ़",
        "श्रावण",
        "भाद्र",
        "आश्विन",
        "कार्तिक",
        "मंसिर",
        "पौष",
        "माघ",
        "फाल्गुन",
        "चैत्र",
      ];
  late String _selectedNepaliMonth;
  String get selectedNepaliMonth => _selectedNepaliMonth;
  set selectedNepaliMonth(String value) {
    _selectedNepaliMonth = value;
    if (_selectedNepaliMonth == "बैशाख") {
      _dateFrom = NepaliDateTime(NepaliDateTime.now().year, 1);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    }
  }

  List<String> get attendanceTypes => ["All", "Present", "Absent"];
  late String _selectedAttendanceType;
  String get selectedAttendanceType => _selectedAttendanceType;
  set selectedAttendanceType(String value) {
    _selectedAttendanceType = value;
    setIdle();
  }

  ///Manually select from_date and to_date of UI components
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _fromDateController = TextEditingController();
  TextEditingController get fromDateController => _fromDateController;

  final TextEditingController _toDateController = TextEditingController();
  TextEditingController get toDateController => _toDateController;

  List<String> get months => [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      ];
  late String _selectedMonth;
  String get selectedMonth => _selectedMonth;
  set selectedMonth(String value) {
    _selectedMonth = value;
    if (_selectedMonth == "January") {
      _dateFrom = DateTime.utc(DateTime.now().year, 1);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "February") {
      _dateFrom = DateTime.utc(DateTime.now().year, 2);
      _dateTo = _dateFrom?.add(const Duration(days: 27));
    } else if (_selectedMonth == "March") {
      _dateFrom = DateTime.utc(DateTime.now().year, 3);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "April") {
      _dateFrom = DateTime.utc(DateTime.now().year, 4);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "May") {
      _dateFrom = DateTime.utc(DateTime.now().year, 5);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "June") {
      _dateFrom = DateTime.utc(DateTime.now().year, 6);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "July") {
      _dateFrom = DateTime.utc(DateTime.now().year, 7);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "August") {
      _dateFrom = DateTime.utc(DateTime.now().year, 8);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "September") {
      _dateFrom = DateTime.utc(DateTime.now().year, 9);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "October") {
      _dateFrom = DateTime.utc(DateTime.now().year, 10);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    } else if (_selectedMonth == "November") {
      _dateFrom = DateTime.utc(DateTime.now().year, 11);
      _dateTo = _dateFrom?.add(const Duration(days: 29));
    } else if (_selectedMonth == "December") {
      _dateFrom = DateTime.utc(DateTime.now().year, 12);
      _dateTo = _dateFrom?.add(const Duration(days: 30));
    }
    setIdle();
  }

  DateTime? _attendanceDate;
  DateTime? get attendanceDate => _attendanceDate;
  set attendanceDate(DateTime? value) {
    _attendanceDate = value;
    setIdle();
  }

  DateTime? _weekFrom;
  DateTime? get weekFrom => _weekFrom;
  DateTime? _weekTo;
  DateTime? get weekTo => _weekTo;
  set weekFrom(DateTime? value) {
    _weekFrom = value;
    _weekTo = _weekFrom?.add(const Duration(days: 6));
    setIdle();
  }

  // for Monthly report
  DateTime? _dateFrom;
  DateTime? get dateFrom => _dateFrom;
  DateTime? _dateTo;
  DateTime? get dateTo => _dateTo;
  set dateFrom(DateTime? value) {
    _dateFrom = value;
    _dateTo = _dateFrom?.add(const Duration(days: 31));
    setIdle();
  }

  set dateTo(DateTime? value) {
    _dateTo = value;
    setIdle();
  }

  bool _returnBack = false;

  Set<CompanyStaffData> _selectedStaffs = {};
  Set<CompanyStaffData> get selectedStaffs => _selectedStaffs;

  // Actions
  void init(AttendanceReportFilterArguments arguments) {
    _filterType = arguments.type;
    _returnBack = arguments.returnBack;
    if (clients != null && clients!.isNotEmpty) {
      _selectedClient = clients!.first;
      _selectedClientLabel = _selectedClient!.name;
    }
    _selectedAttendanceType = attendanceTypes.first;

    if (_filterType == AttendanceReportFilterType.monthly) {
      _selectedMonth = months[DateTime.now().month - 1];
      _selectedNepaliMonth = nepaliMonths[DateTime.now().month - 1];
    }

    if (_filterType == AttendanceReportFilterType.daily) {
      _attendanceDate = DateTime.now();
    }

    setIdle();
  }

  void onViewReportPressed() {
    Map<String, dynamic> _searchParams = {};

    if (_filterType == AttendanceReportFilterType.monthly) {
      _searchParams['date_from'] =
          "${DateTime.now().year}-${(months.indexOf(_selectedMonth) + 1).toString().length == 1 ? '0${months.indexOf(_selectedMonth) + 1}' : months.indexOf(_selectedMonth) + 1}-01";
      _searchParams['date_to'] =
          lastDateOfMonth(months.indexOf(_selectedMonth) + 1);
    } else if (_filterType == AttendanceReportFilterType.daily ||
        _filterType == AttendanceReportFilterType.oneDayReport) {
      _searchParams['date'] =
          '${_attendanceDate!.year}-${_attendanceDate!.month < 10 ? '0${_attendanceDate!.month}' : _attendanceDate!.month}-${_attendanceDate!.day < 10 ? '0${_attendanceDate!.day}' : _attendanceDate!.day}';
    } else {
      _searchParams['begDate'] =
          '${_weekFrom!.year}-${_weekFrom!.month < 10 ? '0${_weekFrom!.month}' : _weekFrom!.month}-${_weekFrom!.day < 10 ? '0${_weekFrom!.day}' : _weekFrom!.day}';
      _searchParams['endDate'] =
          '${_weekTo!.year}-${_weekTo!.month < 10 ? '0${_weekTo!.month}' : _weekTo!.month}-${_weekTo!.day < 10 ? '0${_weekTo!.day}' : _weekTo!.day}';
    }

    if (clients != null && clients!.isNotEmpty) {
      _searchParams['client_id'] = _selectedClient!.clientId;
      _searchParams['client_name'] = _selectedClientLabel;
    }

    _searchParams['type'] = _selectedAttendanceType;

    if (_selectedStaffs.isNotEmpty) {
      if (_filterType == AttendanceReportFilterType.daily &&
          _selectedStaffs.isNotEmpty) {
        _searchParams['user'] = _selectedStaffs.map((e) => e.staffId).toList();
      } else {
        _searchParams['user'] = _selectedStaffs.map((e) => e.userId).toList();
      }
    }

    if (_returnBack) {
      goBack(
        result: AttendanceReportArguments(
          type: _filterType == AttendanceReportFilterType.daily &&
                  _selectedStaffs.isNotEmpty
              ? AttendanceReportFilterType.oneDayReport
              : _filterType,
          searchParams: _searchParams,
        ),
      );
    } else {
      gotoAndPop(
        AttendanceReportView.tag,
        arguments: AttendanceReportArguments(
          type: _filterType == AttendanceReportFilterType.daily &&
                  _selectedStaffs.isNotEmpty
              ? AttendanceReportFilterType.oneDayReport
              : _filterType,
          searchParams: _searchParams,
        ),
      );
    }
  }

  Future<void> onSelectStaffPressed() async {
    final _response = await goto(
      StaffsView.tag,
      arguments: StaffsArguments(
        isSelectMode: true,
        selectedStaffs: _selectedStaffs.toList(),
        isSingleSelect: _filterType == AttendanceReportFilterType.monthly,
        clientId: _selectedClient?.clientId.toString(),
      ),
    );

    debugPrint(_response.toString());

    if (_response != null) {
      if ((_response as Set<CompanyStaffData>).isNotEmpty) {
        _selectedStaffs = _response;
        setIdle();
      }
    }
  }
}
