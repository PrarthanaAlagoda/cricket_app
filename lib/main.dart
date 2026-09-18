import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CricketHomePage(),
    );
  }
}

class CricketHomePage extends StatefulWidget {
  const CricketHomePage({super.key});

  @override
  State<CricketHomePage> createState() => _CricketHomePageState();
}

class _CricketHomePageState extends State<CricketHomePage> {
  int runs = 0;
  int balls = 0;
  int lastRun = 0;

  final Random random = Random();

  void playBall() {
    if (balls >= 6) {
      return;
    }

    final List<int> possibleRuns = [0, 1, 2, 3, 4, 6];
    final int result = possibleRuns[random.nextInt(possibleRuns.length)];

    setState(() {
      lastRun = result;
      runs += result;
      balls++;
    });
  }

  void restartGame() {
    setState(() {
      runs = 0;
      balls = 0;
      lastRun = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool gameFinished = balls >= 6;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Cricket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF07549B),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF087FD1),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          color: Colors.white,
                          child: const Center(
                            child: CustomPaint(
                              size: Size(90, 100),
                              painter: CricketBatPainter(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Runs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$runs',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          color: Colors.white,
                          child: const Center(
                            child: CustomPaint(
                              size: Size(100, 100),
                              painter: CricketBallPainter(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Balls',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$balls',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (gameFinished)
                const Text(
                  '6 Runs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (lastRun == 0 && balls > 0)
                const Text(
                  'No Runs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (balls > 0)
                  Text(
                    '$lastRun ${lastRun == 1 ? "Run" : "Runs"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: gameFinished ? null : playBall,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF07549B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text(
                  'Bat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (gameFinished) ...[
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: restartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CricketBatPainter extends CustomPainter {
  const CricketBatPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint batPaint = Paint()
      ..color = const Color(0xFFE5B978)
      ..style = PaintingStyle.fill;

    final Paint handlePaint = Paint()
      ..color = const Color(0xFF5A6270)
      ..style = PaintingStyle.fill;

    final Paint outlinePaint = Paint()
      ..color = const Color(0xFF4C5665)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path bat = Path();

    bat.moveTo(size.width * 0.30, size.height * 0.80);
    bat.lineTo(size.width * 0.20, size.height * 0.68);
    bat.lineTo(size.width * 0.55, size.height * 0.30);
    bat.lineTo(size.width * 0.70, size.height * 0.42);
    bat.lineTo(size.width * 0.45, size.height * 0.78);
    bat.quadraticBezierTo(
      size.width * 0.38,
      size.height * 0.88,
      size.width * 0.30,
      size.height * 0.80,
    );

    canvas.drawPath(bat, batPaint);
    canvas.drawPath(bat, outlinePaint);

    final Path handle = Path();

    handle.moveTo(size.width * 0.54, size.height * 0.31);
    handle.lineTo(size.width * 0.72, size.height * 0.08);
    handle.lineTo(size.width * 0.82, size.height * 0.16);
    handle.lineTo(size.width * 0.70, size.height * 0.42);
    handle.close();

    canvas.drawPath(handle, handlePaint);
    canvas.drawPath(handle, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CricketBallPainter extends CustomPainter {
  const CricketBallPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ballPaint = Paint()
      ..color = const Color(0xFFFF3333)
      ..style = PaintingStyle.fill;

    final Offset center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final double radius = min(size.width, size.height) * 0.40;

    canvas.drawCircle(center, radius, ballPaint);

    final Paint seamPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path seam1 = Path();

    seam1.moveTo(
      center.dx - radius * 0.65,
      center.dy + radius * 0.60,
    );

    seam1.cubicTo(
      center.dx - radius * 0.20,
      center.dy + radius * 0.10,
      center.dx + radius * 0.25,
      center.dy - radius * 0.15,
      center.dx + radius * 0.70,
      center.dy - radius * 0.60,
    );

    canvas.drawPath(seam1, seamPaint);

    final Path seam2 = Path();

    seam2.moveTo(
      center.dx - radius * 0.58,
      center.dy + radius * 0.72,
    );

    seam2.cubicTo(
      center.dx - radius * 0.12,
      center.dy + radius * 0.22,
      center.dx + radius * 0.35,
      center.dy - radius * 0.05,
      center.dx + radius * 0.78,
      center.dy - radius * 0.48,
    );

    canvas.drawPath(seam2, seamPaint);

    final Path seam3 = Path();

    seam3.moveTo(
      center.dx - radius * 0.48,
      center.dy + radius * 0.80,
    );

    seam3.cubicTo(
      center.dx,
      center.dy + radius * 0.30,
      center.dx + radius * 0.45,
      center.dy,
      center.dx + radius * 0.82,
      center.dy - radius * 0.38,
    );

    canvas.drawPath(seam3, seamPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}