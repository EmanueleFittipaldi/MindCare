import 'package:mindcare/flutter_flow/flutter_flow_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:mindcare/model/umore.dart';

class HumorStatsChart extends StatefulWidget {
  final List<Umore> data;
  final PageController pageViewController;
  final String tipoUmore;
  final String typeChart;
  const HumorStatsChart({
    Key? key,
    required this.data,
    required this.tipoUmore,
    required this.typeChart,
    required this.pageViewController,
  }) : super(key: key);

  @override
  _HumorStatsChartState createState() => _HumorStatsChartState();
}

class _HumorStatsChartState extends State<HumorStatsChart> {
  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior3;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    _tooltipBehavior1 = TooltipBehavior(
      enable: true,
    );
    _tooltipBehavior2 = TooltipBehavior(
      enable: true,
    );
    _tooltipBehavior3 = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    super.initState();
  }

  createChart(String typeHumor, List<Umore> data) {
    List<Umore> dataTypeH = [];

    data.forEach((d) {
      if (d.type == typeHumor) {
        dataTypeH.add(d);
      }
    });

    if (dataTypeH.isEmpty) {
      return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
          child: Text('Non ci sono dati per questo tipo!',
              style: FlutterFlowTheme.of(context).bodyText2.override(
                    fontFamily: 'IBM Plex Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )));
    }
    Color color = Colors.black;
    TooltipBehavior tooltipBehavior = _tooltipBehavior1;
    switch (typeHumor) {
      case 'giornaliero':
        color = const Color(0xFF4589FF);
        tooltipBehavior = _tooltipBehavior1;
        break;
      case 'ricordi':
        color = const Color(0xFF24A148);
        tooltipBehavior = _tooltipBehavior2;
        break;
      case 'quiz':
        color = const Color(0xFFEE5396);
        tooltipBehavior = _tooltipBehavior3;
        break;
    }

    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        zoomPanBehavior: _zoomPanBehavior,
        palette: <Color>[color],
        onTooltipRender: (tooltipArgs) {
          var dataCurrent = dataTypeH[tooltipArgs.pointIndex!.toInt()];
          tooltipArgs.header = dataCurrent.type;
          tooltipArgs.text =
              'Data: ${DateFormat('dd-MM-yyyy HH:mm').format(dataCurrent.data).toString()}\nScore: ${dataCurrent.score}';
        },
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            isVisible: false,
            maximumLabels: 6,
            visibleMaximum: 10,
            arrangeByIndex: true,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelStyle:
                const TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 10)),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
          maximumLabels: 2,
        ),
        tooltipBehavior: tooltipBehavior,
        series: <ChartSeries>[
          widget.typeChart == 'Grafico a barre'
              ? ColumnSeries<Umore, String>(
                  dataSource: dataTypeH,
                  xValueMapper: (Umore data, _) =>
                      DateFormat('dd-MM-yyyy hh:mm aaa')
                          .format(DateTime.parse(data.data.toString()))
                          .toString(),
                  yValueMapper: (Umore data, _) =>
                      double.parse((data.score.toStringAsFixed(2))),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      useSeriesColor: true,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyText1
                          .override(
                              fontFamily: 'IBM Plex Sans',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 12)))
              : LineSeries<Umore, String>(
                  dataSource: dataTypeH,
                  xValueMapper: (Umore data, _) =>
                      DateFormat('dd-MM-yyyy hh:mm aaa')
                          .format(DateTime.parse(data.data.toString()))
                          .toString(),
                  yValueMapper: (Umore data, _) =>
                      double.parse((data.score.toStringAsFixed(2))),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    useSeriesColor: true,
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'IBM Plex Sans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 12),
                  ),
                )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1, 2, 1, 16),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                blurRadius: 12,
                color: Color(0x14000000),
                offset: Offset(0, 5),
              )
            ],
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            )),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 40,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20,
                          ),
                          onPressed: () {
                            widget.pageViewController.previousPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.linear);
                          }),
                      Text(
                        'Umore ' + widget.tipoUmore,
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'IBM Plex Sans',
                              color: const Color(0xFF101213),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 40,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20,
                          ),
                          onPressed: () {
                            widget.pageViewController.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.linear);
                          }),
                    ]),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(),
                      clipBehavior: Clip.antiAlias,
                      width: double.infinity,
                      child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 10),
                          child: createChart(widget.tipoUmore, widget.data)))),
            ],
          ),
        ),
      ),
    );
  }
}
