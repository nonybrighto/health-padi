import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthpadi/providers/scroll_list_model.dart';
import 'package:healthpadi/utilities/load_state.dart';
import 'package:stacked/stacked.dart';

enum ScrollListType { grid, list }

class ScrollListView<T extends ScrollListModel, W> extends StatefulWidget {
  final Function onLoad;
  final Widget Function({W item, int index, W previousItem})
      currentListItemWidget;
  final int gridCrossAxisCount;
  final PageStorageKey pageStorageKey;
  final ScrollController scrollController;
  final ScrollListType scrollListType;
  final T Function() viewModelBuilder;

  ScrollListView({
    Key key,
    this.viewModelBuilder,
    this.onLoad,
    this.currentListItemWidget,
    this.gridCrossAxisCount,
    this.scrollListType = ScrollListType.list,
    this.pageStorageKey,
    this.scrollController
  }) : super(key: key);

  @override
  _ScrollListState<T, W> createState() => new _ScrollListState<T, W>();
}

class _ScrollListState<T extends ScrollListModel, W>
    extends State<ScrollListView<T, W>> {
  ScrollController _scrollController;
  // bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);

    if (widget.onLoad != null) {
      Future.microtask(() => widget.onLoad());
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000) {
      widget.onLoad();
      // canLoadMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.reactive(
        disposeViewModel: false,
        viewModelBuilder: widget.viewModelBuilder,
        onModelReady: (model) {
          // widget.onLoad();
        },
        builder: (context, model, child) {
          LoadState loadState = model.loadState;

          List<W> items = model.items;

          //if it is the first load
          if (loadState is Loading && loadState.more == false ||
              loadState == null) {
            return _initialProgress();
          } else if (loadState is LoadError && loadState.more == false) {
            return _initialError(loadState.message, onRetry: () {
              widget.onLoad();
            });
          } else if (loadState is LoadedEmpty) {
            return _showEmpty(loadState.message);
          } else {
            if (widget.scrollListType == ScrollListType.list) {
              return _buildListView(loadState, items, widget.pageStorageKey);
            } else if (widget.scrollListType == ScrollListType.grid) {
              return _buildGridView(loadState, items);
            }
            //if error occurs while there is already content
            // if (loadState is LoadError) {
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Scaffold.of(context).showSnackBar(SnackBar(
            //       content: Text('Error while loading'),
            //     ));
            //   });
            // }
            return Container();
          }
        });
  }

  _initialProgress() {
    return Center(
      child: SpinKitCubeGrid(
        color: Theme.of(context).primaryColor,
        size: 40,
      ),
    );
  }

  _initialError(String message, {Function onRetry}) {
    // return MainErrorDisplay(
    //   errorMessage: message,
    //   buttonText: 'RETRY',
    //   onErrorButtonTap: onRetry,
    // );
    return Text('Error');
  }

  _showEmpty(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  _buildListView(
      LoadState loadState, List<W> listItems, PageStorageKey pageStorageKey) {
    return ListView.builder(
      key: pageStorageKey,
      controller: _scrollController,
      itemCount: (loadState is Loading) //when loading more
          ? listItems.length + 1
          : listItems.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < listItems.length) {
          return widget.currentListItemWidget(
              index: index,
              item: listItems[index],
              previousItem: index != 0 ? listItems[index - 1] : null);
        } else if (loadState is Loading) {
          return _buildBottomProgress();
        }
        return Container();
      },
    );
  }

  _buildGridView(LoadState loadState, List<W> listItems) {
    return new CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.gridCrossAxisCount,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return widget.currentListItemWidget(
                      index: index,
                      item: listItems[index],
                      previousItem: index != 0 ? listItems[index - 1] : null);
                },
                childCount: listItems.length,
              )),
          SliverToBoxAdapter(
            child:
                (loadState is Loading) ? _buildBottomProgress() : Container(),
          ),
        ]);
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
