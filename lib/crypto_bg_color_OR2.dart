import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';
import 'buy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Hiragino Sans'),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    const c1 = Color(0xFFF4A491);
    const c2 = Color(0xFFF09361);
    const c3 = Color(0xFFE8590C);
    const c4 = Color(0xFFBE4809);
    const c5 = Color(0xFF9D3C08);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: OMeshGradient(
              mesh: OMeshRect(
                width: 3,
                height: 3,
                backgroundColor: c3,
                fallbackColor: c3,
                vertices: [
                  (-0.08, -0.05).v,
                  (0.52, -0.08).v,
                  (1.08, 0.02).v,
                  (-0.12, 0.42).v,
                  (0.60, 0.42).v,
                  (1.10, 0.45).v,
                  (-0.05, 1.08).v,
                  (0.48, 1.02).v,
                  (1.05, 1.05).v,
                ],
                colors: const [c1, c2, c3, c3, c3, c2, c5, c4, c4],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'crypto_bg_color_OR2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                _buildBottomButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBF0000),
            shape: const StadiumBorder(),
            elevation: 0,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const BuyPage(),
            );
          },
          child: const Text(
            '注文',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
