import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';
import 'buy.dart';
import 'survey_section.dart';

const _hiraFont = TextStyle(fontFamily: 'Hiragino Sans');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Bitcoinカラー
    const btcOrange = Color(0xFFF7931A);
    const btcLight = Color(0xFFFFB347);
    const btcYellow = Color(0xFFFFC94D);
    const btcDark = Color(0xFFD97706);
    const btcDeep = Color(0xFFE67E22);

    return Scaffold(
      body: Stack(
        children: [
          // 1. 背景層（メッシュグラデーション）
          Positioned.fill(
            child: OMeshGradient(
              mesh: OMeshRect(
                width: 3,
                height: 3,
                backgroundColor: btcOrange,
                fallbackColor: btcOrange,
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
                colors: const [
                  btcYellow,
                  btcLight,
                  btcOrange,
                  btcOrange,
                  btcOrange,
                  btcLight,
                  btcDark,
                  btcDeep,
                  Color(0xFFFF8F3D),
                ],
              ),
            ),
          ),

          // 2. コンテンツ層
          SafeArea(
            child: Column(
              children: [
                // 上部：スクロール可能エリア
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // タイトル部分
                        const SizedBox(height: 40),
                        Text(
                          "Bitcoin Background",
                          style: _hiraFont.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ★ Figmaから取り込んだセクション
                        const SurveySection(),
                      ],
                    ),
                  ),
                ),

                // 下部にボタンを配置（固定）
                _buildBottomButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 下部ボタンのメソッド
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
          child: Text(
            '注文',
            style: _hiraFont.copyWith(
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
