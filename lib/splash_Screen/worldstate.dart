import 'package:covid_tracker/modell/WorldStatesModel.dart';
import 'package:covid_tracker/services/state_services.dart';
import 'package:covid_tracker/splash_Screen/countrie_material.dart';
import 'package:covid_tracker/widgets/reuseable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync:this )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
  }
  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {
    StateServcies stateServcies = StateServcies();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              FutureBuilder(
                  future: stateServcies.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel>snapshot){

                if(!snapshot.hasData){
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                  );
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap:{
                          'Total': double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                          'Deaths': double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        chartRadius:  MediaQuery.of(context).size.width/3.2,
                        legendOptions: LegendOptions(
                            legendPosition:  LegendPosition.left
                        ),

                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.disc,
                        colorList: colorList,

                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                        child: Card(
                          child: Column(
                            children: [
                              ReUseablerow(title: 'Total', value: snapshot.data!.cases!.toString()),
                              ReUseablerow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                              ReUseablerow(title: 'Death', value: snapshot.data!.deaths!.toString()),
                              ReUseablerow(title: 'Active', value: snapshot.data!.active!.toString()),
                              ReUseablerow(title: 'Critical', value: snapshot.data!.critical!.toString()),
                              ReUseablerow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toString()),
                              ReUseablerow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> CountriesScreen()));
                    },

                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],

                  );

                }
              }),

            ],
          ),
        ),

      ),

    );
  }
}
