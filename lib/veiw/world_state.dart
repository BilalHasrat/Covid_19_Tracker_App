import 'package:covid_19_app/services/state_services.dart';
import 'package:covid_19_app/veiw/country_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      vsync: this)..repeat();

    final colorList = [
      const Color(0xff4285F4),
      const Color(0xff1aa260),
      const Color(0xffde5246),
    ];

  @override
  Widget build(BuildContext context) {
    StateServices  stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .02,),

              FutureBuilder(
                future: stateServices.getWorldStateRecord(),
                  builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Expanded(
                      flex: 1,
                      child: Center(child: CircularProgressIndicator(),)
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap:  {
                          "Total":double.parse(snapshot.data!.cases.toString()),
                          "Recover": double.parse(snapshot.data!.recovered.toString()),
                          "Death":double.parse(snapshot.data!.deaths.toString()),
                        },

                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,),

                        chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true),

                        animationDuration: Duration(milliseconds: 1200),
                        colorList :colorList,
                        chartType: ChartType.ring,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,

                      ),

                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *.05),
                        child: Card(
                          color: Colors.white54,
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                              ReusableRow(title: 'Recover', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active.toString(),),
                              ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recover', value: snapshot.data!.todayRecovered.toString()),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .02,),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                        },
                        child: Container(
                          height:   50,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Center(child: Text('Track Contries'),),
                        ),
                      )
                    ],
                  );
                }
              }),


            ],
          ),
        ),),
    );
  }
}
class ReusableRow extends StatelessWidget {

  String title, value;

   ReusableRow({Key? key,
     required this.title,
     required this.value
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10, bottom:5 ),
      child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 20,),),
            Text(value,style: TextStyle(fontSize: 20,)),


          ],
        ),
        SizedBox(height: 5,),

      ],
      ),
    );
  }
}

