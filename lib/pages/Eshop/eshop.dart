import 'dart:convert';

import 'package:gold247/constant/constant.dart';
import 'package:gold247/models/SingleItemDetail.dart';
import 'package:gold247/models/item.dart';
import 'package:gold247/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gold247/language/locale.dart';

class Eshop extends StatefulWidget {
  Eshop({this.id, this.type});
  final String id;
  final String type;

  @override
  _EshopState createState() => _EshopState();
}

class _EshopState extends State<Eshop> {
  List<ItemList> ItemDetails;
  List<String> items = [];

  List<String> distinctIds;
  List<List<ItemList>> item;

  Future fetchItem(String id, String type) async {
    final queryParameters = {
      type: id,
    };
    final uri =
        Uri.http('goldv2.herokuapp.com', '/api/itemdetails/', queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseString = await jsonDecode(response.body);
      Iterable l = responseString['data'];
      ItemDetails =
          List<ItemList>.from(l.map((model) => ItemList.fromJson(model)));
      for (int i = 0; i < ItemDetails.length; i++) {
        items.add(ItemDetails[i].item.sId.toString());
      }
      distinctIds = items.toSet().toList();
      item = new List.generate(distinctIds.length, (i) => []);
      for (int i = 0; i < distinctIds.length; i++) {
        List<ItemList> temp = [];
        for (int j = 0; j < ItemDetails.length; j++) {
          if (ItemDetails[j].item.sId == distinctIds[i]) {
            temp.add(ItemDetails[j]);
          }
        }
        if (temp.isNotEmpty) item[i] = temp;
      }
    } else {
      print(response.reasonPhrase);
    }
    return item;
  }

  @override
  void initState() {
    super.initState();
  }

  int initPosition = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchItem(widget.id, widget.type),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: scaffoldBgColor,
                body: Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ))),
          );
        } else {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: scaffoldBgColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: whiteColor,
                title: Center(
                  child: Text(
                    'E-Shop',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              body: CustomTabView(
                initPosition: initPosition,
                itemCount: distinctIds.length,
                tabBuilder: (context, index) =>
                    Tab(text: item[index][0].item.name),
                pageBuilder: (context, index) {
                  return Goldcoins(
                    item: item[index],
                  );
                },
                onPositionChange: (index) {
                  print('current position: $index');
                  initPosition = index;
                },
                onScroll: (position) => print('$position'),
              ),
            );
          } else {
            return errorScreen;
          }
        }
      },
    );

    // TabBarView(
    //   children: [
    //     Goldcoins(),
    //     Completed(),
    //   ],
    // ),
  }
}

class CustomTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final Widget stub;
  final ValueChanged<int> onPositionChange;
  final ValueChanged<double> onScroll;
  final int initPosition;

  CustomTabView({
    @required this.itemCount,
    @required this.tabBuilder,
    @required this.pageBuilder,
    this.stub,
    this.onPositionChange,
    this.onScroll,
    this.initPosition,
  });

  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabView>
    with TickerProviderStateMixin {
  TabController controller;
  int _currentCount;
  int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition ?? 0;
    controller = TabController(
      length: widget.itemCount,
      vsync: this,
      initialIndex: _currentPosition,
    );
    controller.addListener(onPositionChange);
    controller.animation.addListener(onScroll);
    _currentCount = widget.itemCount;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      controller.animation.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }

      _currentCount = widget.itemCount;
      setState(() {
        controller = TabController(
          length: widget.itemCount,
          vsync: this,
          initialIndex: _currentPosition,
        );
        controller.addListener(onPositionChange);
        controller.animation.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      controller.animateTo(widget.initPosition);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.animation.removeListener(onScroll);
    controller.removeListener(onPositionChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: controller,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
              (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: List.generate(
              widget.itemCount,
              (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    );
  }

  onPositionChange() {
    if (!controller.indexIsChanging) {
      _currentPosition = controller.index;
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  onScroll() {
    if (widget.onScroll is ValueChanged<double>) {
      widget.onScroll(controller.animation.value);
    }
  }
}
