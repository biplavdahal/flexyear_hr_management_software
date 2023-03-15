import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/company_staff.data.dart';
import 'package:flex_year_tablet/services/authentication.service.dart';
import 'package:flex_year_tablet/services/company.service.dart';
import 'package:flex_year_tablet/ui/personal/staffs/staffs.arguments.dart';
import 'package:flutter/material.dart';

class StaffsModel extends ViewModel with SnackbarMixin {
  // Services
  final CompanyService _companyService = locator<CompanyService>();

  // UI controllers
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  // Data
  bool _isSelectMode = false;
  bool get isSelectMode => _isSelectMode;

  String _query = "";
  String get query => _query;
  set query(String value) {
    _query = value;
    setIdle();
  }

  bool _isSingleSelect = false;
  bool get isSingleSelect => _isSingleSelect;

  bool _preventSelf = false;

  List<CompanyStaffData> _staffs = [];

  List<CompanyStaffData> get staffsToShow => _staffs
      .where((element) =>
          element.fullName.toLowerCase().contains(query.toLowerCase()))
      .toList();

  final Set<CompanyStaffData> _selectedStaffs = {};
  Set<CompanyStaffData> get selectedStaffs => _selectedStaffs;
  void addSelectedStaffs(CompanyStaffData staff) {
    debugPrint(staff.toString());
    debugPrint(locator<AuthenticationService>().user!.id.toString());
    debugPrint(_preventSelf.toString());

    if (staff.userId == locator<AuthenticationService>().user!.id.toString() &&
        _preventSelf) {
      snackbar.displaySnackbar(
          SnackbarRequest.of(message: "You can not select yourself!"));
      return;
    }

    if (_isSingleSelect) {
      _selectedStaffs.clear();
      _selectedStaffs.add(staff);
      goBack(result: _selectedStaffs);
    } else {
      if (_selectedStaffs.contains(staff)) {
        _selectedStaffs.remove(staff);
      } else {
        _selectedStaffs.add(staff);
      }
      setIdle();
    }
  }

  bool isSelected(CompanyStaffData staff) => _selectedStaffs.contains(staff);

  // Action
  Future<void> init(StaffsArguments? arguments) async {
    if (arguments != null) {
      _isSelectMode = arguments.isSelectMode;
      if (arguments.selectedStaffs != null) {
        _selectedStaffs.addAll(arguments.selectedStaffs!);
      }
      _isSingleSelect = arguments.isSingleSelect;
      _preventSelf = arguments.preventSelf;
    }
    setIdle();

    try {
      setLoading();

      _staffs = await _companyService.getStaffs(clientId: arguments!.clientId);

      _searchController.addListener(() {
        query = _searchController.text;
      });

      setIdle();
    } catch (e) {
      setIdle();
      snackbar.displaySnackbar(SnackbarRequest.of(message: e.toString()));
    }
  }
}
