import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/album_ricordi/ricordo_widget.dart';
import 'package:mindcare/controller/auth.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
// ignore: depend_on_referenced_packages
import 'package:timeline_list/timeline.dart';
// ignore: depend_on_referenced_packages
import 'package:timeline_list/timeline_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/ricordo.dart';

class TimelinePage extends StatefulWidget {
  final String caregiverUID;
  final List<Ricordo> doodles;
  const TimelinePage(
      {Key? key, required this.caregiverUID, required this.doodles})
      : super(key: key);
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  String? fileName;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: <Widget>[
          for (var item in widget.doodles)
            InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RicordoWidget(
                          ricordo: item,
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).backgroundPrimaryColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Color(0x14000000),
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(children: <Widget>[
                  Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: item.tipoRicordo == 'Immagine'
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                item.filePath,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              clipBehavior: Clip.antiAlias,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: SizedBox(
                                      width: 1,
                                      height: 1,
                                      child: FlutterFlowVideoPlayer(
                                        path: item.filePath,
                                        videoType: VideoType.network,
                                        autoPlay: true,
                                        looping: false,
                                        showControls: false,
                                        allowFullScreen: false,
                                        allowPlaybackSpeedMenu: false,
                                      ))))),
                  Align(
                    alignment: AlignmentDirectional(0, 0.9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              item.titolo,
                              textAlign: TextAlign.start,
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 30,
                                      ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              item.annoRicordo.toString(),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
        ],
        options: CarouselOptions(
          height: 500,
          enlargeCenterPage: true,
        ));
  }
}
