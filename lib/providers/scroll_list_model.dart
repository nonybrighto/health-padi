import 'package:flutter/cupertino.dart';
import 'package:healthpadi/models/list_response.dart';
import 'package:healthpadi/utilities/load_state.dart';

abstract class ScrollListModel<T> extends ChangeNotifier {
  int currentPage = 1;
  List<T> _items = [];
  LoadState _loadState;

  List<T> get items => _items;
  LoadState get loadState => _loadState;

  String emptyResultMessage = '';
  bool forceLoad = false;
  bool hasReachedMax = false;

  fetchItems(Function serverCallback) async {
    if (canLoadMore()) {
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
        hasReachedMax = gottenResponse.currentPage == gottenResponse.totalPages;
        _loadState = (currentPage == 1 && gottenItems.isEmpty)
            ? LoadedEmpty(emptyResultMessage)
            : Loaded(hasReachedMax: hasReachedMax);
        currentPage++;
      } catch (error) {
        _loadState = LoadError(message: error.message, more: currentPage > 1);
      }
      forceLoad = false;
      notifyListeners();
    }
  }

  setLoadState(LoadState loadState) {
    _loadState = loadState;
    notifyListeners();
  }

  setHasReachedMax(bool reachedMax) {
    hasReachedMax = reachedMax;
  }

  setItems(List<T> items) {
    this._items = items;
    notifyListeners();
  }

  appendItems(List<T> items) {
    _items.addAll(items);
  }

  startForceLoad() {
    forceLoad = true;
  }

  bool canLoadMore() {
    return _loadState == null ||
        ((_loadState is Loaded && !hasReachedMax) &&
            !(loadState is LoadError)) ||
        forceLoad;
  }
}
