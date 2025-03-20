// import 'package:covid_tracker/Model/world_satates_model.dart';
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// import '../Services/states_services.dart';
// import 'country_list.dart';
//
// class WorldStates extends StatefulWidget {
//   const WorldStates({Key? key}) : super(key: key);
//
//   @override
//   State<WorldStates> createState() => _WorldStatesState();
// }
//
// class _WorldStatesState extends State<WorldStates>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(seconds: 3),
//     vsync: this,
//   )..repeat();
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   final colorList = <Color>[
//     const Color(0xff4285F4),
//     const Color(0xff1aa260),
//     const Color(0xffde5246),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     StatesServices statesServices = StatesServices();
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             FutureBuilder(future: statesServices.fetchWorldStatesRecords(),
//                  builder:(context,AsyncSnapshot<CovidStats> snapshot){
//
//               if(snapshot.hasData){
//                 return Expanded(flex: 1,child:SpinKitCircle(
//                   color: Colors.white,
//                   size: 50,
//                   controller: _controller,
//                 ),);
//               }else{
//                 return Column(
//                   children: [
//                     PieChart(
//                       dataMap: {
//                         "Total": double.parse(snapshot.data!.cases.toString()),
//                         "Recovered": double.parse(snapshot.data!.recovered.toString()),
//                         "Deaths": double.parse(snapshot.data!.deaths.toString()),
//                       },
//                       chartValuesOptions: const ChartValuesOptions(
//                         showChartValuesInPercentage: true,
//                       ),
//                       chartRadius: MediaQuery.of(context).size.width / 3.2,
//                       legendOptions: const LegendOptions(
//                         legendPosition: LegendPosition.left,
//                       ),
//                       animationDuration: const Duration(milliseconds: 1200),
//                       chartType: ChartType.ring,
//                       colorList: colorList,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06) ,
//                       child: Card(
//                         child: Column(
//                           children: [
//                             ResuableRow(title: "Total", value: snapshot.data!.cases.toString(),),
//                             ResuableRow(title: "Deaths", value: snapshot.data!.deaths.toString(),),
//                             ResuableRow(title: "Recovered", value: snapshot.data!.recovered.toString(),),
//                             ResuableRow(title: "Active", value: snapshot.data!.active.toString(),),
//                             ResuableRow(title: "Critical", value: snapshot.data!.critical.toString(),),
//                             ResuableRow(title: "TodayDeaths", value: snapshot.data!.todayDeaths.toString(),),
//                             ResuableRow(title: "TodayRecovered", value: snapshot.data!.todayRecovered.toString(),),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:  (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryList()));
//                       },
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Color(0xff1aa260),
//                             borderRadius:  BorderRadius.circular(10)
//                         ),
//                         child: Center(
//                           child: Text("Track Counires"),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               }
//             }),
//
//           ],
//         ),
//       )),
//     );
//   }
// }
//
// class ResuableRow extends StatelessWidget {
//   String title, value;
//   ResuableRow({Key? key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(title),
//               Text(value),
//             ],
//           ),
//           SizedBox(height: 5,),
//           Divider()
//         ],
//       ),
//     );
//   }
// }
import 'package:covid_tracker/Model/world_satates_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/states_services.dart';
import 'country_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<CovidStats> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Failed to load data. Please try again."),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ResuableRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ResuableRow(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ResuableRow(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ResuableRow(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                ResuableRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ResuableRow(
                                    title: "TodayDeaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ResuableRow(
                                    title: "TodayRecovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuableRow extends StatelessWidget {
  final String title, value;
  const ResuableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}
