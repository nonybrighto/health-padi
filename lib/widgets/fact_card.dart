import 'package:flutter/material.dart';
import 'package:healthpadi/models/fact.dart';
import 'package:healthpadi/models/fact_category.dart';

class FactCard extends StatelessWidget {
  final Fact fact;
  FactCard({this.fact});
  @override
  Widget build(BuildContext context) {
    double radiusSize = 10;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSize),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(radiusSize))),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        Text(
                          fact.type,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(radiusSize),
                        bottomRight: Radius.circular(radiusSize))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      fact.content,
                      style: TextStyle(fontSize: 20),
                    ),
                    _buildCategoryDisplay(fact.category)
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  _buildCategoryDisplay(FactCategory category) {
    return Container(
      margin: EdgeInsets.only(top:3),
      padding: EdgeInsets.all(3),
      color: Colors.grey[300],
      child: Text(category.name),
    );
  }
}
