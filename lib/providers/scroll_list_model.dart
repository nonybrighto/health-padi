import 'package:flutter/cupertino.dart';
import 'package:healthpadi/utilities/list_response.dart';
import 'package:healthpadi/utilities/load_state.dart';

abstract class ScrollListModel<T> extends ChangeNotifier {
  int currentPage = 1;
  List<T> _items = [];
  LoadState _loadState;

  List<T> get items => _items;
  LoadState get loadState => _loadState;

  String emptyResultMessage = '';
  bool forceLoad = false;
  bool _hasReachedMax = false;


  fetchItems(Function serverCallback) async {
  if(canLoadMore()){
      _loadState = Loading(more: currentPage != 1);
      notifyListeners();
    try {
      ListResponse gottenResponse = await serverCallback();
      List<T> gottenItems = gottenResponse.results.toList();

      if (currentPage == 1) {
        _items = gottenItems;
      } else {
        _items.addAll(gottenItems);
      }
      _hasReachedMax = gottenResponse.currentPage == gottenResponse.totalPages;
      _loadState = (currentPage == 1 && gottenItems.isEmpty)
          ? LoadedEmpty(emptyResultMessage)
          : Loaded(
              hasReachedMax: _hasReachedMax
                  );
      currentPage++;
    } catch (error) {
      _loadState = LoadError(message: error.message, more: currentPage > 1);
    }
    forceLoad = false;
    notifyListeners();
  }
  }

  bool canLoadMore(){
    return _loadState  == null || ((_loadState is Loaded && !_hasReachedMax) && !(loadState is LoadError)) || forceLoad;
  }
}
