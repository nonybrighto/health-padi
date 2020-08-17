import 'package:healthpadi/models/fact.dart';
import 'package:healthpadi/models/fact_category.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/services/remote/fact_remote.dart';
import 'package:healthpadi/utilities/locator.dart';

class FactListModel extends ScrollListModel<Fact> {
  List<FactCategory> _factCategories = [];
  FactCategory _selectedCategory;
  FactRemote factRemote = locator<FactRemote>();

  List<FactCategory> get factCategories => _factCategories;
  FactCategory get selectedCategory => _selectedCategory;

  FactListModel(){
    emptyResultMessage = 'No facts found';
  }

  fetchFacts() async {
    await fetchItems(() {
      return factRemote.fetchFact(
          page: currentPage, category: _selectedCategory);
    });
  }

  fetchCategories() async {
    List<FactCategory> categories = await factRemote.fetchCategories();
    _factCategories = categories;
    notifyListeners();
  }

  changeSelectedCategory(FactCategory selectedCategory) {
    currentPage = 1;
    forceLoad = true;
    setHasReachedMax(false);
    _selectedCategory = selectedCategory;
    notifyListeners();
  }
}
