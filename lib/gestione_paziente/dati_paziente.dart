import 'package:mindcare/appbar/appbar_caregiver.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DatiPazienteWidget extends StatefulWidget {
  const DatiPazienteWidget({Key? key}) : super(key: key);

  @override
  _DatiPazienteWidgetState createState() => _DatiPazienteWidgetState();
}

class _DatiPazienteWidgetState extends State<DatiPazienteWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;

  late bool passwordVisibility1;
  TextEditingController? textController3;

  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'paziente');
    textController2 = TextEditingController(text: 'paziente');
    passwordVisibility1 = false;
    textController3 = TextEditingController();
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppbarcaregiverWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://procedural-generation.isaackarth.com/tumblr_files/tumblr_pnpkvnwpWI1uo5d9jo5_1280.jpg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giuseppe Giglio',
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    header: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
                      child: Text(
                        'Informazioni paziente',
                        style: FlutterFlowTheme.of(context).subtitle2,
                      ),
                    ),
                    collapsed: Text(
                      'empty',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'IBM Plex Sans',
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                          ),
                    ),
                    expanded: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                'Giuseppe',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Cognome: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                'Giglio',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Data di nascita: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                '10/01/1959',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Anni: ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Text(
                                '63',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    header: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
                      child: Text(
                        'Modifica password',
                        style: FlutterFlowTheme.of(context).subtitle2,
                      ),
                    ),
                    collapsed: Text(
                      'empty',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'IBM Plex Sans',
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                          ),
                    ),
                    expanded: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 5),
                            child: TextFormField(
                              controller: textController1,
                              autofocus: true,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Username:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 5),
                            child: TextFormField(
                              controller: textController2,
                              autofocus: true,
                              obscureText: !passwordVisibility1,
                              decoration: InputDecoration(
                                labelText: 'Password:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility1 =
                                        !passwordVisibility1,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility1
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF757575),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 5),
                            child: TextFormField(
                              controller: textController3,
                              autofocus: true,
                              obscureText: !passwordVisibility2,
                              decoration: InputDecoration(
                                labelText: 'Conferma password:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .borderErrorColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility2 =
                                        !passwordVisibility2,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF757575),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'IBM Plex Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 15),
                            child: FFButtonWidget(
                              onPressed: () {},
                              text: 'Salva',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    header: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 4, 0),
                      child: Text(
                        'Cancella paziente',
                        style: FlutterFlowTheme.of(context).subtitle2,
                      ),
                    ),
                    collapsed: Text(
                      'empty',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'IBM Plex Sans',
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                          ),
                    ),
                    expanded: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 15),
                              child: FFButtonWidget(
                                onPressed: () {},
                                text: 'Elimina paziente',
                                options: FFButtonOptions(
                                  width: 170,
                                  height: 40,
                                  color: const Color(0xFFC11215),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'IBM Plex Sans',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    theme: const ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
