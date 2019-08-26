import 'package:flutter/material.dart';

class DietLabels extends StatelessWidget {
 
 final labels;
 DietLabels(this.labels);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: labels == null ? 0 : labels.length,
             itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Card(
                  color: Colors.white,
                  child: Container(
                    child: Center(child: Text('${labels[index]}', style: TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),)),
                  ),
                ),
              );
  
             }),
);
  }
}