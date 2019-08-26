import 'package:flutter/material.dart';


class Content extends StatelessWidget {

final String result;
final String heading;
final String unit;
Content(this.result, this.heading, this.unit);

 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
             padding: EdgeInsets.all(4),
            child: Card(
        
        child: Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16),
        child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                Text(heading, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                Text(result  ?? '',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.blueAccent)),
                Text(unit ,style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
              ],
            ),
        )
  ),
      ),
    );
  }
}