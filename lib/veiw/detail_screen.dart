import 'package:covid_19_app/veiw/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image, name;
  int? totalCases, totalDeaths, totalRecover, active, critical, todayRecover, test;

   DetailScreen({Key? key,
   required this.totalCases,
     required this.test,
     required this.todayRecover,
     required this.totalDeaths,
     required this.totalRecover,
     required this.critical,
     required this.active,
     required this.name,
     required this.image,

   }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),

      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height *.10),
                  child: Card(
                    color: Colors.orangeAccent.shade100,
                    child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height *.06,),
                          ReusableRow(title: 'Total Cases', value: widget.totalCases.toString(),),
                          ReusableRow(title: 'Total Death', value: widget.totalDeaths.toString(),),
                          ReusableRow(title: 'Total Recover', value: widget.totalRecover.toString(),),
                          ReusableRow(title: 'Critical', value: widget.critical.toString(),),
                          ReusableRow(title: 'Active', value: widget.active.toString(),),
                          ReusableRow(title: 'Today Recover', value: widget.todayRecover.toString(),)

                        ],),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
