import 'package:covid_tracker/services/state_services.dart';
import 'package:covid_tracker/splash_Screen/detail_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServcies stateServcies = StateServcies();
    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
     body: SafeArea(
       child: Column(
         children: [
           Padding(
             padding: EdgeInsets.all(8.0),
             child: TextFormField(
               onChanged: (value){
                 setState(() {

                 });
               },
               controller: searchController,
               decoration: InputDecoration(
                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
                 hintText: 'search with country name',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50.0),
                 ),
               ),
             ),
           ),
           Expanded(
               child: FutureBuilder(
                 future: stateServcies.countriesListApi(),
                 builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                   if(!snapshot.hasData){
                     return ListView.builder(
                         itemCount: 50,
                         itemBuilder: (context, index){
                           return Shimmer.fromColors(

                               baseColor: Colors.grey.shade700,
                               highlightColor: Colors.grey.shade100,
                             child:Column(
                               children: [
                                 ListTile(
                                   title: Container(
                                     height: 10,
                                     width: 89,
                                     color: Colors.white,
                                     //Text(snapshot.data![index]['country']),
                                   ),
                                   subtitle: Container(
                                     height: 10,
                                       width: 89,
                                     color: Colors.white,
                                     //Text(snapshot.data![index]['cases'].toString()),
                                   ),
                                   leading: Container(
                                     height: 50,
                                     width: 50,
                                     color: Colors.white,
                                       // Image(
                                       //
                                       //   height: 50,
                                       //   width: 50,
                                       //   image: NetworkImage(
                                       //       snapshot.data![index]['countryInfo']['flag']
                                       //   ),
                                       // )
                                   ),
                                 ),
                               ],
                             ),
                           );

                         });;
                   }else{
                     return ListView.builder(
                         itemCount: snapshot.data!.length,
                         itemBuilder: (context, index){
                           String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=> DetailScreen(
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            name: snapshot.data![index]['country'],
                                            totalCases: snapshot.data![index]['cases'],
                                            todayRecovered: snapshot.data![index]['recovered'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            active: snapshot.data![index]['active'],
                                            test: snapshot.data![index]['tests'],
                                            totalRecovered: snapshot.data![index]['todayRecovered'],
                                            critical: snapshot.data![index]['critical'],

                                          )));
                                    },
                                    
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(

                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=> DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]['cases'],
                                      todayRecovered: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      totalRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],

                                    )));
                              },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(

                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }else{
                              return Container(
                              height: 20,
                                width: double.infinity,
                                child: Text('No Country match'),
                              );
                            }
                       return Column(
                         children: [
                        ListTile(
                          title: Text(snapshot.data![index]['country']),
                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                          leading: Image(

                            height: 50,
                            width: 50,
                            image: NetworkImage(
                          snapshot.data![index]['countryInfo']['flag']
                          ),
                          ),
                        ),
                         ],
                       );
                     });
                   }

                   },
               ),
           ),
         ],
       ),
     ),
    );
  }
}
