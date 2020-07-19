import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plannusandroidversion/models/rating/rateable.dart';

class DetailedEvent extends StatefulWidget {
  final String eventTitle;
  final Rateable event;
  final double longitude;
  final double latitude;
  DetailedEvent(this.eventTitle, this.event, this.longitude, this.latitude);
  @override
  _DetailedEventState createState() => _DetailedEventState();
}

class _DetailedEventState extends State<DetailedEvent> {
  List<Marker> _markers = new List<Marker>();
  List<String> voters;
  List<String> feedback;

  @override
  void initState() {
    super.initState();
    _markers.add(
        Marker(
          markerId: MarkerId('Main'),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(
              title: '' + widget.eventTitle,
              snippet: widget.event.event.location
          ),
        )
    );
    voters = widget.event.reviews.keys.toList();
    feedback = widget.event.reviews.values.toList();
    //convertFromLocation(widget.location);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading:
            IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          title: Center(
            widthFactor: 2.75,
            child: Text(widget.eventTitle.toUpperCase(),
                style: GoogleFonts.lato(fontSize: 24),
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200, //MediaQuery.of(context).size.height/3,
                width: 300, //MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition:
                  CameraPosition(
                      target:LatLng(widget.latitude, widget.longitude),
                      zoom: 18
                  ),
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(_markers),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                    child: Text('Rating', style: GoogleFonts.openSans(fontSize: 24),)
                ),
              ),
              Container(
                padding: EdgeInsets.all(3),
                child: Row(
                  children: <Widget>[
                    RatingBar(
                      unratedColor: Colors.grey,
                      allowHalfRating: true,
                      initialRating: widget.event.currRating,
                      minRating: 0,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow[400],
                        size: 26,
                      ),
                      onRatingUpdate: (newRating) {},
                      ignoreGestures: true,
                    ),
                    Container(
                      child: Text('(' + widget.event.votes.toString() + ')',
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                    ),
                 ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: Text('Reviews',
                    style: GoogleFonts.lato(fontSize: 24),
                  )
              ),
              Container(
//                child: ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: voters.length,
//                  itemBuilder: (BuildContext context, int index) => ListView(
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                        Text(voters[index]),
//                        Text(feedback[index])
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}