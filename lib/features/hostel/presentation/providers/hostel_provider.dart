// hostel_provider.dart
import 'package:flutter/material.dart';
import 'package:hostel_finder/features/hostel/data/hostel_model.dart';

class HostelProvider with ChangeNotifier {
  List<HostelModel> _hostels = [];

  List<HostelModel> get hostels => _hostels;

  void addHostel(HostelModel hostel) {
    _hostels.add(hostel);
    notifyListeners();
  }

  void setHostels(List<HostelModel> hostels) {
    _hostels = hostels;
    notifyListeners();
  }
}