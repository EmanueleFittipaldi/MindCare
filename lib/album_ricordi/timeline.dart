import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/album_ricordi/ricordo_widget.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
// ignore: depend_on_referenced_packages
// ignore: depend_on_referenced_packages
import '../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_util.dart';
// ignore: depend_on_referenced_packages
import 'package:auto_size_text/auto_size_text.dart';
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
                      alignment: const AlignmentDirectional(0, 0),
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
                    alignment: const AlignmentDirectional(0, 1),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(91, 9, 15, 19),
                            Color(0x00F4F4F4)
                          ],
                          stops: [0.6, 1],
                          begin: AlignmentDirectional(0, 1),
                          end: AlignmentDirectional(0, -1),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: AutoSizeText(
                                  item.titolo,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 0, 0),
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
