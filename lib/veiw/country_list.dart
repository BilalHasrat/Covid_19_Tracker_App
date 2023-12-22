import 'package:covid_19_app/services/state_services.dart';
import 'package:covid_19_app/veiw/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),

    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search with country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: stateServices.getCountriesRecords(),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

                  if(!snapshot.hasData){

                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context,index){

                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade700,
                            child: Column(
                              children: [
                                ListTile(
                                    leading: Container(height: 50,width: 50,color: Colors.white,),

                                    title:  Container(height: 10,width: 89,color: Colors.white,),

                                    subtitle:  Container(height: 10,width: 89,color: Colors.white,),
                                ),

                              ],
                            ),
                          );
                        });

                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                        var countryName = snapshot.data![index]['country'];
                        if(_controller.text.isEmpty){
                          return Column(
                            children: [
                              ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    totalCases: snapshot.data![index]['cases'],
                                    test: snapshot.data![index]['test'],
                                    todayRecover: snapshot.data![index]['todayRecover'],
                                    totalDeaths: snapshot.data![index]['totalDeaths'],
                                    totalRecover: snapshot.data![index]['totalRecover'],
                                    critical: snapshot.data![index]['critical'],
                                    active: snapshot.data![index]['active'],
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'])));
                              },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 70,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  ),

                                  title: Text(snapshot.data![index]['country']),

                                  subtitle: Text('Cases'+ ' : '+snapshot.data![index]['cases'].toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                  trailing: Text('Deaths' + ' - '+snapshot.data![index]['deaths'].toString(),)
                              ),

                            ],
                          );

                        }else if(countryName.toLowerCase().contains(_controller.text.toLowerCase())){
                          return Column(
                        children: [
                          ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    totalCases: snapshot.data![index]['cases'],
                                    test: snapshot.data![index]['test'],
                                    todayRecover: snapshot.data![index]['todayRecover'],
                                    totalDeaths: snapshot.data![index]['totalDeaths'],
                                    totalRecover: snapshot.data![index]['totalRecover'],
                                    critical: snapshot.data![index]['critical'],
                                    active: snapshot.data![index]['active'],
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'])));
                              },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image(
                                fit: BoxFit.cover,
                                height: 50,
                                width: 70,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                            ),

                            title: Text(snapshot.data![index]['country']),
                            
                            subtitle: Text('Cases'+ ' : '+snapshot.data![index]['cases'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text('Deaths' + ' - '+snapshot.data![index]['deaths'].toString(),)
                          ),

                        ],
                      );
                        }else{
                          return Container();
                        }
                    });
                  }
                },
              )
          )
        ],
      ),
    ),
    );
  }
}
