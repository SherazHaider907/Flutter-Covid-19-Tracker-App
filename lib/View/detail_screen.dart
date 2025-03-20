import 'package:flutter/material.dart';
import 'world_states.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  const DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * .067) ,
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height * .06,),
                        ResuableRow(
                          title: 'Cases',
                          value: widget.totalCases.toString(),
                        ),
                        ResuableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                        ResuableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString(),
                        ),
                        ResuableRow(
                          title: 'Critical',
                          value: widget.critical.toString(),
                        ),
                        ResuableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString(),
                        ),
                        // Add more ReusableRow widgets here
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
          // Add more widgets to the Column here
        ],
      ),
    );
  }
}