import 'package:flutter/material.dart';
import 'btc_price_card.dart';
import 'survey_section.dart';

const _fontFamily = 'Hiragino Kaku Gothic Pro';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BtcDetailPage(),
    );
  }
}

class BtcDetailPage extends StatefulWidget {
  const BtcDetailPage({super.key});

  @override
  State<BtcDetailPage> createState() => _BtcDetailPageState();
}

class _BtcDetailPageState extends State<BtcDetailPage> {
  int _navIndex = 2; // 注文がデフォルト選択

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 背景: Figma準拠レイヤー構成
          // Layer 1: メイン対角グラデーション（黄→赤）
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, 0.00),
                  end: Alignment(1.00, 1.00),
                  colors: [Color(0xFFFCCF31), Color(0xFFF55555)],
                ),
              ),
            ),
          ),
          // Layer 2: グレー縦グラデーション（上部を暗くし下部を透明に）
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.45, 1.00),
                  colors: [
                    Color(0x606A6A6E),
                    Color(0x40555558),
                    Color(0x204B4B4E),
                    Color(0x00424244),
                  ],
                ),
              ),
            ),
          ),

          // コンテンツ
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // 上部バッジエリア
                _buildTopBadge(),

                // スクロール可能なメインコンテンツ
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        // チャートカード（横スクロール風 + ページインジケーター）
                        _buildChartSection(),
                        const SizedBox(height: 12),

                        // ページインジケーター
                        _buildPageDots(),
                        const SizedBox(height: 8),

                        // アンケート・BTC情報セクション（白い丸角エリア）
                        const SurveySection(),

                        // ボトムバー分の余白
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 固定ボトム（売る/買うバー + ナビゲーション）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomArea(context),
          ),
        ],
      ),
    );
  }

  // 現物バッジ
  Widget _buildTopBadge() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 8, bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
              ),
              child: const Center(
                child: Text(
                  '₿',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              '現物',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: _fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // チャートカードエリア（横パディング付き）
  Widget _buildChartSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const BtcPriceCard(),
    );
  }

  // ページインジケータードット
  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Container(
          width: i < 2 ? 8 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: i < 2
                ? const Color(0xFFE8317B)
                : Colors.white.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  // ボトムエリア（売る/買うバー + ナビゲーション）
  Widget _buildBottomArea(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSellBuyBar(),
        _buildBottomNav(bottomPadding),
      ],
    );
  }

  // 売る/買うバー
  Widget _buildSellBuyBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // 売る
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '16,845,997円',
                  style: TextStyle(
                    color: Color(0xFF009B8D),
                    fontSize: 12,
                    fontFamily: _fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009B8D),
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      '売る',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // 買う
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '16,845,997円',
                  style: TextStyle(
                    color: Color(0xFFE8317B),
                    fontSize: 12,
                    fontFamily: _fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8317B),
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      '買う',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ボトムナビゲーション
  Widget _buildBottomNav(double bottomPadding) {
    const items = [
      _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'ホーム'),
      _NavItem(icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart, label: '銘柄一覧'),
      _NavItem(icon: Icons.swap_horiz_outlined, activeIcon: Icons.swap_horiz, label: '注文'),
      _NavItem(icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet, label: '資産'),
      _NavItem(icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view, label: 'メニュー'),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: List.generate(items.length, (i) {
          final isActive = i == _navIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _navIndex = i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive ? items[i].activeIcon : items[i].icon,
                      size: 22,
                      color: isActive
                          ? const Color(0xFFBF0000)
                          : const Color(0xFF999999),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[i].label,
                      style: TextStyle(
                        color: isActive
                            ? const Color(0xFFBF0000)
                            : const Color(0xFF999999),
                        fontSize: 10,
                        fontFamily: _fontFamily,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
}
