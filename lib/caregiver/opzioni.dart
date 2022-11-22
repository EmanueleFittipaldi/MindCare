import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
// ignore: unused_import
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../login.dart';

class OpzioniWidget extends StatefulWidget {
  const OpzioniWidget({Key? key}) : super(key: key);

  @override
  _OpzioniWidgetState createState() => _OpzioniWidgetState();
}

class _OpzioniWidgetState extends State<OpzioniWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;

  late bool passwordVisibility1;
  TextEditingController? textController5;

  late bool passwordVisibility2;
  TextEditingController? textController6;

  late bool passwordVisibility3;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'Teresa');
    textController2 = TextEditingController(text: 'D\'amico');
    textController3 = TextEditingController(text: 't.damico@gmail.com');
    textController4 = TextEditingController();
    passwordVisibility1 = false;
    textController5 = TextEditingController();
    passwordVisibility2 = false;
    textController6 = TextEditingController();
    passwordVisibility3 = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    textController6?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xFFEBF9FF),
                    size: 30,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                    child: Text(
                      'MindCare',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'IBM Plex Sans',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 2,
        ),
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
                            'https://thumbs.dreamstime.com/b/portrait-indian-asian-female-medical-doctor-hospital-office-happy-smiling-stethoscope-asian-indian-female-woman-161674392.jpg',
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
                              'Teresa',
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: Text(
                                'ID: 0001',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: const Color(0xB4FFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                        'Modifica dati',
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
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nome:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
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
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Cognome:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
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
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFFE0E3E7),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '24/08/1993',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'IBM Plex Sans',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.date_range_outlined,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 5),
                            child: TextFormField(
                              controller: textController3,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
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
                        'Cambia password',
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
                              controller: textController4,
                              autofocus: true,
                              obscureText: !passwordVisibility1,
                              decoration: InputDecoration(
                                labelText: 'Password attuale:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
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
                              controller: textController5,
                              autofocus: true,
                              obscureText: !passwordVisibility2,
                              decoration: InputDecoration(
                                labelText: 'Nuova password:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
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
                                0, 15, 0, 5),
                            child: TextFormField(
                              controller: textController6,
                              autofocus: true,
                              obscureText: !passwordVisibility3,
                              decoration: InputDecoration(
                                labelText: 'Conferma password:',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility3 =
                                        !passwordVisibility3,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    passwordVisibility3
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
              padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
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
                        'Termini & Servizi',
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
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 15),
                              child: Text(
                                'Lorem ipsum Lorem ipsum Lorem ipsum  Lorem ipsumLorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumLorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'IBM Plex Sans',
                                      fontWeight: FontWeight.w200,
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginWidget()));
                },
                text: 'Esci',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'IBM Plex Sans',
                        color: Colors.white,
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
    );
  }
}
