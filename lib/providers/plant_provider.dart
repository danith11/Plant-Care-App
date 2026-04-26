import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../services/api_service.dart';

class PlantProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Plant> _plants = [];
  bool _isLoading = false;
  String _errorMessage = '';

  String _searchQuery = '';
  String _filterType = 'All';

  List<Plant> get plants {
    return _plants.where((plant) {
      final matchesSearch = plant.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesFilter = _filterType == 'All' || plant.type == _filterType;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get filterType => _filterType;

// Fetch Plants
  Future<void> fetchPlants() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _plants = await _apiService.getPlants();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// Add plants
  Future<bool> addPlant(Plant plant) async {
    try {
      final newPlant = await _apiService.createPlant(plant);
      _plants.add(newPlant);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

// Update Plants
  Future<bool> updatePlant(Plant plant) async {
    try {
      await _apiService.updatePlant(plant);
      final index = _plants.indexWhere((p) => p.id == plant.id);
      if (index != -1) {
        _plants[index] = plant;
        notifyListeners();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

// Delete plant
  Future<bool> deletePlant(String id) async {
    try {
      await _apiService.deletePlant(id);
      _plants.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterType(String type) {
    _filterType = type;
    notifyListeners();
  }
}
