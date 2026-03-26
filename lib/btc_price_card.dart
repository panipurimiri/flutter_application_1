import 'package:flutter/material.dart';
import 'dart:math' as math;

class BtcPriceCard extends StatefulWidget {
  const BtcPriceCard({super.key});

  @override
  State<BtcPriceCard> createState() => _BtcPriceCardState();
}

class _BtcPriceCardState extends State<BtcPriceCard> {
  int _selectedPeriod = 0;

  static const List<double> _chartData = [
    191000, 190000, 189000, 188500, 187500, 186000, 185000, 184500,
    184000, 183500, 183500, 184000, 185500, 187000, 188500, 190000,
    192000, 193500, 195000, 196000, 197500, 196500, 197800, 198500,
  ];

  static const _fontFamily = 'Hiragino Kaku Gothic Pro';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x6BF1F1F1),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildPrice(),
          _buildChart(),
          _buildTimePeriodSelector(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // BTC icon
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFCC31F), Color(0xFFF7931A)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '₿',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'BTC',
                        style: TextStyle(
                          color: Color(0xFF4D4D4D),
                          fontSize: 20,
                          fontFamily: _fontFamily,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xFF4D4D4D),
                      ),
                    ],
                  ),
                  const Text(
                    'ビットコイン',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 11,
                      fontFamily: _fontFamily,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.format_list_bulleted, size: 20, color: Color(0xFF999999)),
              SizedBox(width: 12),
              Icon(Icons.star_border_rounded, size: 20, color: Color(0xFF999999)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            '16,845,997円',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 28,
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          SizedBox(height: 2),
          Text(
            '+0.45 %',
            style: TextStyle(
              color: Color(0xFFE8317B),
              fontSize: 13,
              fontFamily: _fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: CustomPaint(
          painter: _LineChartPainter(data: _chartData),
          size: const Size(double.infinity, 180),
        ),
      ),
    );
  }

  Widget _buildTimePeriodSelector() {
    const periods = ['時', '日', '週', '月', '年'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ...List.generate(periods.length, (i) {
            final isSelected = i == _selectedPeriod;
            return GestureDetector(
              onTap: () => setState(() => _selectedPeriod = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(right: 2),
                decoration: isSelected
                    ? BoxDecoration(
                        border: Border.all(color: const Color(0xFFE8317B)),
                        borderRadius: BorderRadius.circular(128),
                      )
                    : null,
                child: Text(
                  periods[i],
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFFE8317B)
                        : const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: _fontFamily,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w300,
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          const Icon(
            Icons.candlestick_chart_outlined,
            size: 18,
            color: Color(0xFFAAAAAA),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;

  const _LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    const double leftMargin = 12;
    const double rightMargin = 52;
    const double topMargin = 4;
    const double bottomMargin = 22;

    final double chartWidth = size.width - leftMargin - rightMargin;
    final double chartHeight = size.height - topMargin - bottomMargin;

    final double minVal = data.reduce(math.min);
    final double maxVal = data.reduce(math.max);
    final double range = maxVal - minVal;

    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final x = leftMargin + (i / (data.length - 1)) * chartWidth;
      final y = topMargin + (1 - (data[i] - minVal) / range) * chartHeight;
      points.add(Offset(x, y));
    }

    // Grid lines + Y labels
    final gridLinePaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 0.5;

    const yLabelValues = [198000.0, 192000.0, 188000.0];
    const labelStyle = TextStyle(
      color: Color(0xFF999999),
      fontSize: 10,
      fontFamily: 'Hiragino Kaku Gothic Pro',
    );

    for (final yVal in yLabelValues) {
      final yPixel =
          topMargin + (1 - (yVal - minVal) / range) * chartHeight;
      if (yPixel < topMargin - 4 || yPixel > topMargin + chartHeight + 4) {
        continue;
      }
      _drawDashedLine(
        canvas,
        Offset(leftMargin, yPixel),
        Offset(leftMargin + chartWidth, yPixel),
        gridLinePaint,
      );
      final label = '${(yVal / 1000).toStringAsFixed(0)}.000';
      final tp = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(leftMargin + chartWidth + 4, yPixel - tp.height / 2),
      );
    }

    // Gradient fill
    final fillPath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      fillPath.lineTo(p.dx, p.dy);
    }
    fillPath.lineTo(points.last.dx, topMargin + chartHeight);
    fillPath.lineTo(points.first.dx, topMargin + chartHeight);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFE8317B).withValues(alpha: 0.18),
          const Color(0xFFE8317B).withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromLTWH(0, topMargin, size.width, chartHeight),
      );
    canvas.drawPath(fillPath, fillPaint);

    // Line
    final linePaint = Paint()
      ..color = const Color(0xFFE8317B)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      linePath.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(linePath, linePaint);

    // X-axis labels
    const xLabels = ['12:00', '4:00', '8:00', '12:00'];
    for (int i = 0; i < xLabels.length; i++) {
      final x = leftMargin + (i / (xLabels.length - 1)) * chartWidth;
      final tp = TextPainter(
        text: TextSpan(text: xLabels[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(x - tp.width / 2, size.height - bottomMargin + 4),
      );
    }
  }

  void _drawDashedLine(
      Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 3.0;
    const dashSpace = 3.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    if (length == 0) return;

    final unitDx = dx / length;
    final unitDy = dy / length;

    double progress = 0;
    bool drawing = true;

    while (progress < length) {
      final step = drawing ? dashWidth : dashSpace;
      final end0 = math.min(progress + step, length);
      if (drawing) {
        canvas.drawLine(
          Offset(start.dx + unitDx * progress, start.dy + unitDy * progress),
          Offset(start.dx + unitDx * end0, start.dy + unitDy * end0),
          paint,
        );
      }
      progress = end0;
      drawing = !drawing;
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) => false;
}
