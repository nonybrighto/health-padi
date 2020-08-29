import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:healthpadi/models/fact.dart';
import 'package:healthpadi/models/fact_category.dart';
import 'package:healthpadi/providers/fact_list_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/fact_card.dart';
import 'package:healthpadi/widgets/views/scroll_list_view.dart';
import 'package:provider/provider.dart';

class FactsView extends StatefulWidget {
  @override
  _FactsViewState createState() => _FactsViewState();
}

class _FactsViewState extends State<FactsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<FactListModel>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: <Widget>[
          _buildFactCategories(),
          Expanded(
              child: ScrollListView<FactListModel, Fact>(
            viewModelBuilder: () => Provider.of<FactListModel>(context),
            onLoad: () =>
                Provider.of<FactListModel>(context, listen: false).fetchFacts(),
            currentListItemWidget: (
                    {int index, Fact item, Fact previousItem}) =>
                FactCard(fact: item),
          ))
        ],
      ),
    );
  }

  _buildFactCategories() {
    final factModel = Provider.of<FactListModel>(context);
    final selectedCategory = factModel.selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: AnimationLimiter(
        child: Row(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 200.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
        if (factModel.factCategories != null &&
            factModel.factCategories.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ChoiceChip(
              selected: selectedCategory == null,
              label: Text('All'),
              onSelected: (selected) {
                _fetchCategory(null);
              },
            ),
          ),
        for (FactCategory category in factModel.factCategories)
          Padding(
            padding: const EdgeInsets.all(1),
            child: ChoiceChip(
              selected: selectedCategory != null &&
                  selectedCategory.id == category.id,
              label: Text(category.name),
              onSelected: (selected) {
                _fetchCategory(category);
              },
            ),
          ),
      ],
          ),
        ),
      ),
    );

  }

  _fetchCategory(FactCategory category) {
    FactListModel factModel =
        Provider.of<FactListModel>(context, listen: false);
    factModel.changeSelectedCategory(category);
    factModel.fetchFacts();
  }
}
