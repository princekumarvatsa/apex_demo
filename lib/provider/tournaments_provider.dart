import 'package:apex_demo/model/tournaments.dart';
import 'package:apex_demo/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class TournamentsProvider with ChangeNotifier {
  final HttpService _httpService = HttpService();
  int _pageNumber = 1;
  bool _hasMoreData = true;
  final int _batchCount = 10;
  bool _isLoading = false;
  bool _loadingMoreData = false;
  Tournament _responseData = Tournament();
  List<Tournaments> _tournaments = <Tournaments>[];

  HasError httpError = HasError(false, "");

  List<Tournaments> get tournaments => _tournaments;
  bool get isLoading => _isLoading;
  bool get loadingMoreData => _loadingMoreData;
  bool get hasMoreData => _hasMoreData;

  void setTournaments(List<Tournaments>? newTournaments) {
    _tournaments.addAll(newTournaments!);
    final Set<Tournaments> _set = {..._tournaments};
    _tournaments = _set.toList();
    httpError = HasError(false, "");
    notifyListeners();
  }

  Future<void> loadTournaments() async {
    if (_hasMoreData && !_isLoading) {
      _isLoading = true;
      await getTournamentsFromServer(_pageNumber);
      _isLoading = false;
    }
  }

  Future<void> loadMoreTournaments() async {
    if (_hasMoreData && !_isLoading) {
      _loadingMoreData = true;
      await getTournamentsFromServer(_pageNumber);
      _loadingMoreData = false;
    }
  }

  Future<void> getTournamentsFromServer(int page) async {
    Map<String, String> queries = {"limit": "$_batchCount", "status": "all"};
    if (_hasMoreData && _pageNumber > 1) {
      queries.addAll({"cursor": "${_responseData.data!.cursor}"});
    }
    try {
      Tournament? response = await _httpService.getTournamentsData(queries);
      if (response != null && response.success == true) {
        _responseData = response;
        _pageNumber++;
        if (response.data!.isLastBatch == true) {
          _hasMoreData = false;
        } else {
          _hasMoreData = true;
        }
        setTournaments(response.data!.tournaments);
      }
    } catch (e) {
      httpError = HasError(true, e.toString().replaceFirst("Exception", "Error"));
      notifyListeners();
    }
  }
}

class HasError {
  final String error;
  final bool hasError;
  HasError(this.hasError, this.error);
}
