import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:healthpadi/widgets/error_indicator.dart';
import 'package:healthpadi/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class ScrollListView<T extends ScrollListModel, W> extends StatefulWidget {
  final Function onLoad;
  final bool loadOnInit;
  final Widget Function({W item, int index, List<W> allItems})
      currentListItemWidget;
  final ScrollController scrollController;
  final T Function() viewModelBuilder;
  final bool reverse;

  ScrollListView(
      {Key key,
      this.viewModelBuilder,
      this.onLoad,
      this.loadOnInit = true,
      this.currentListItemWidget,
      this.reverse = false,
      this.scrollController})
      : super(key: key);

  @override
  _ScrollListState<T, W> createState() => new _ScrollListState<T, W>();
}

class _ScrollListState<T extends ScrollListModel, W>
    extends State<ScrollListView<T, W>> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);

    if (widget.onLoad != null && widget.loadOnInit) {
      Future.microtask(() => widget.onLoad());
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000) {
      if (widget.onLoad != null) {
        widget.onLoad();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LoadState loadState =
        context.select<T, LoadState>((model) => model.loadState);
    List<W> items = context.select<T, List<W>>((model) => model.items);

    //if it is the first load
    if (loadState is Loading && loadState.more == false || loadState == null) {
      return _initialProgress();
    } else if (loadState is LoadError && loadState.more == false) {
      return _initialError(loadState.message, onRetry: () {
        widget.onLoad();
      });
    } else if (loadState is LoadedEmpty) {
      return _showEmpty(loadState.message);
    } else {
      return _buildListView(loadState, items);
    }
  }

  _initialProgress() {
    return LoadingIndicator();
  }

  _initialError(String message, {Function onRetry}) {
    return ErrorIndicator(
      errorMessage: message,
      onRetry: onRetry,
    );
  }

  _showEmpty(String message) {
    return ErrorIndicator(
      errorMessage: message,
      isEmpty: true,
    );
  }

  _buildListView(LoadState loadState, List<W> listItems) {
    return Column(
      children: <Widget>[
        AnimationLimiter(
          child: Expanded(
            child: ListView.builder(
              reverse: widget.reverse,
              controller: _scrollController,
              itemCount: listItems.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget.currentListItemWidget(
                        index: index,
                        item: listItems[index],
                        allItems: listItems,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (loadState is Loading) _buildBottomProgress()
      ],
    );
  }

  _buildBottomProgress() {
    return Center(
      child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
    );
  }
}
