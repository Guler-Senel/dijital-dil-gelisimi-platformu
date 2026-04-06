import 'package:flutter/material.dart';

// Uygulamanın başlangıç noktası
void main() {
  // Ana uygulama widget'ını çalıştırır
  runApp(const KidlinguaApp());
}

// Uygulamanın kök widget'ı
class KidlinguaApp extends StatelessWidget {
  const KidlinguaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sağ üstte görünen debug yazısını kaldırır
      debugShowCheckedModeBanner: false,

      // Uygulama adı
      title: 'KidLingua',

      // Uygulamanın genel tema ayarları
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE8F8E0),
        fontFamily: 'Arial',
      ),

      // İlk açılan ekran
      home: const RoleSelectionScreen(),
    );
  }
}

/* ---------------------------------------------------------- */
/* COLORS */
/* ---------------------------------------------------------- */

// Uygulama içinde tekrar tekrar kullanılan renklerin tutulduğu sınıf
class AppColors {
  static const bg = Color(0xFFDDF7D4); // genel arka plan
  static const green = Color(0xFF59E77A);
  static const darkGreen = Color(0xFF0A5B20);
  static const textGreen = Color(0xFF126A2B);
  static const yellow = Color(0xFFF2D233);
  static const yellowDark = Color(0xFF7A6400);
  static const blue = Color(0xFF0A67AB);
  static const lightBlue = Color(0xFFD6ECFF);
  static const pink = Color(0xFFFFB0B0);
  static const whiteCard = Colors.white;
  static const shadow = Color(0x33000000); // gölge rengi
}

/* ---------------------------------------------------------- */
/* ROLE SELECTION */
/* ---------------------------------------------------------- */

// Kullanıcının çocuk mu ebeveyn mi olduğunu seçtiği ilk ekran
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Ekranın tamamını kaplar
        width: double.infinity,
        height: double.infinity,

        // Arka plan geçişli renk
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDDF8D8), Color(0xFFCFF3C8), Color(0xFFBDF0AF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),

            // Tüm içerik dikey olarak yerleştirilir
            child: Column(
              children: [
                const SizedBox(height: 18),

                // Ana başlık
                const Text(
                  "Kimsin?",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF7A5A00),
                  ),
                ),

                const SizedBox(height: 10),

                // Alt açıklama
                const Text(
                  "Yolculuğuna başlamak için bir karakter seç!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGreen,
                  ),
                ),

                const SizedBox(height: 28),

                // Çocuk kartı ve onun üst etiketi aynı anda gösteriliyor
                Stack(
                  children: [
                    _roleCard(
                      context: context,
                      cardColor: Colors.white,
                      circleColor: AppColors.yellow,
                      icon: Icons.rocket_launch_rounded,
                      iconColor: const Color(0xFF5A4800),
                      title: "Çocuk",
                      titleColor: AppColors.darkGreen,
                      desc:
                          "Yeni kelimeler keşfet, oyunlar oyna ve yıldızları topla!",
                      descColor: AppColors.textGreen,
                      buttonText: "BAŞLAYALIM!  →",
                      buttonColor: const Color(0xFF8E7600),

                      // Çocuk butonuna basılınca çocuk ana ekranına gider
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChildMainScreen(),
                          ),
                        );
                      },
                    ),

                    // Kartın üst köşesindeki pembe küçük etiket
                    Positioned(
                      top: 8,
                      right: 10,
                      child: Transform.rotate(
                        angle: -0.12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            "EĞLENCE DOLU",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF6B2424),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Ebeveyn kartı
                _roleCard(
                  context: context,
                  cardColor: const Color(0xFFDDF4FA),
                  circleColor: AppColors.blue,
                  icon: Icons.family_restroom_rounded,
                  iconColor: Colors.white,
                  title: "Ebeveyn",
                  titleColor: AppColors.blue,
                  desc:
                      "Gelişimi takip et ve çocuğunun öğrenme macerasını yönet.",
                  descColor: const Color(0xFF15658F),
                  buttonText: "GİRİŞ YAP",
                  buttonColor: AppColors.blue,

                  // Ebeveyn butonuna basılınca ebeveyn ana ekranına gider
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ParentScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Rol kartını tekrar kullanılabilir şekilde oluşturan yardımcı fonksiyon
  Widget _roleCard({
    required BuildContext context,
    required Color cardColor,
    required Color circleColor,
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color titleColor,
    required String desc,
    required Color descColor,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),

      // Kart görünümü
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        children: [
          // Karttaki yuvarlak ikon alanı
          Container(
            width: 118,
            height: 118,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, size: 56, color: iconColor),
          ),

          const SizedBox(height: 20),

          // Kart başlığı
          Text(
            title,
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.w900,
              color: titleColor,
            ),
          ),

          const SizedBox(height: 10),

          // Kart açıklaması
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: descColor,
            ),
          ),

          const SizedBox(height: 24),

          // Kart butonu
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* CHILD MAIN SHELL */
/* ---------------------------------------------------------- */

// Çocuk ekranlarının ana gövdesi
// Alt menü sayesinde sayfalar arasında geçiş yapılır
class ChildMainScreen extends StatefulWidget {
  const ChildMainScreen({super.key});

  @override
  State<ChildMainScreen> createState() => _ChildMainScreenState();
}

class _ChildMainScreenState extends State<ChildMainScreen> {
  // Şu anda seçili olan alt menü index'i
  int selectedIndex = 0;

  // Alt menüde gösterilecek sayfalar
  final List<Widget> pages = const [
    ChildHomePage(),
    ChildTasksPage(),
    ChildLearnPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      // Seçili index'e göre ilgili sayfa açılır
      body: pages[selectedIndex],

      // Alt menü alanı
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home sekmesi
            _bottomItem(
              index: 0,
              current: selectedIndex,
              icon: Icons.home_rounded,
              label: 'Home',
              activeColor: AppColors.yellow,
              onTap: () => setState(() => selectedIndex = 0),
            ),

            // Tasks sekmesi
            _bottomItem(
              index: 1,
              current: selectedIndex,
              icon: Icons.star_rounded,
              label: 'Tasks',
              activeColor: AppColors.yellow,
              onTap: () => setState(() => selectedIndex = 1),
            ),

            // Learn sekmesi
            _bottomItem(
              index: 2,
              current: selectedIndex,
              icon: Icons.menu_book_rounded,
              label: 'Learn',
              activeColor: AppColors.yellow,
              onTap: () => setState(() => selectedIndex = 2),
            ),
          ],
        ),
      ),
    );
  }

  // Alt menü öğesini oluşturan yardımcı widget
  Widget _bottomItem({
    required int index,
    required int current,
    required IconData icon,
    required String label,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    // Eğer index ile mevcut seçili index aynıysa aktif sekmedir
    final bool isActive = index == current;

    return GestureDetector(
      onTap: onTap,
      child: isActive
          // Aktif görünüm
          ? Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 8,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: const Color(0xFF3B2E00), size: 30),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Color(0xFF3B2E00),
                    ),
                  ),
                ],
              ),
            )
          // Pasif görünüm
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: const Color(0xFF72A37A), size: 30),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF72A37A),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
    );
  }
}

/* ---------------------------------------------------------- */
/* CHILD HOME */
/* ---------------------------------------------------------- */

// Çocuk ana sayfası
class ChildHomePage extends StatelessWidget {
  const ChildHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KidBgScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
        child: Column(
          children: [
            // Üst bar
            const _TopBarSmall(title: "KidLingua"),
            const SizedBox(height: 18),

            // Günün kelimesi kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              decoration: _mainCardDecoration(),
              child: Column(
                children: [
                  Row(
                    children: [
                      _smallPill("Günün Kelimesi", AppColors.yellow),
                      const Spacer(),
                      _iconButtonPill(
                        label: "DİNLE",
                        icon: Icons.volume_up_rounded,
                        color: AppColors.yellow,
                        textColor: const Color(0xFF534200),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Görsel alanı
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8CB6A6),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Center(
                      child: Text("🐦", style: TextStyle(fontSize: 160)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Kelime başlığı
                  const Text(
                    "KUŞ",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF7A6500),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Alt çizgi efekti
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // İlerleme kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFAED0FF),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // İkon
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: AppColors.blue,
                          size: 38,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Yazılar
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3 Kelime Öğren",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppColors.blue,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Harika Gidiyorsun!",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Sayısal ilerleme
                  const Text(
                    "2 / 3",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // İlerleme barı
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      minHeight: 18,
                      value: 0.66,
                      backgroundColor: Color(0x80FFFFFF),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.blue),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Alt kısım menü kutuları
            Row(
              children: [
                Expanded(
                  child: _squareMenuCard(
                    color: AppColors.yellow,
                    icon: Icons.menu_book_rounded,
                    iconColor: const Color(0xFF584600),
                    text: "Hikayeler",
                    textColor: const Color(0xFF584600),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _squareMenuCard(
                    color: const Color(0xFFAED0FF),
                    icon: Icons.account_tree_rounded,
                    iconColor: AppColors.blue,
                    text: "Oyunlar",
                    textColor: AppColors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* CHILD TASKS */
/* ---------------------------------------------------------- */

// Çocuğun görev ekranı
class ChildTasksPage extends StatelessWidget {
  const ChildTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KidBgScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        child: Column(
          children: [
            // Üst bar
            const _TopBarSmall(title: "Görevlerin"),
            const SizedBox(height: 18),

            // Başlık
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Harika!\nYıldızlarını Topla",
                style: TextStyle(
                  fontSize: 34,
                  height: 1.15,
                  fontWeight: FontWeight.w900,
                  color: AppColors.darkGreen,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Bilgilendirme satırı
            const Row(
              children: [
                Icon(Icons.stars_rounded, color: Colors.green, size: 30),
                SizedBox(width: 8),
                Text(
                  "Bugün 3 yeni görevin var",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textGreen,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Görev kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
              decoration: _mainCardDecoration(),
              child: Column(
                children: [
                  // Görev görseli
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8ECEC),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text("🧑", style: TextStyle(fontSize: 110)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  _smallPill("YENİ ÖĞREN", const Color(0xFFFFD9DF)),
                  const SizedBox(height: 14),

                  // Görev kelimesi
                  const Text(
                    "Elma",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Görev açıklaması
                  const Text(
                    "Bu meyvenin adını sesli söyleyebilir\nmisin?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreen,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tamamla butonu
                  _bigButton(
                    text: "✔  Tamamla",
                    color: AppColors.yellow,
                    textColor: const Color(0xFF5A4700),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Günlük ilerleme kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
              decoration: BoxDecoration(
                color: const Color(0xFFD7F5E2),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: const Color(0xFF9BC8FF),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  // Dairesel ilerleme
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: 0.33,
                          strokeWidth: 10,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.blue,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "1/3",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Harika Gidiyorsun!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "2 görev daha yaparsan büyük ödülü\nkazanırsın.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Son aktiviteler başlığı
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Son Aktiviteler",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.darkGreen,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Aktivite kartı 1
            _activityCard(
              leadingEmoji: "🐾",
              title: "Hayvanlar Ünitesi\nTamamlandı",
              subtitle: "Bugün, 14:20",
              iconBg: const Color(0xFF69F28A),
              rightIcon: Icons.check_circle,
            ),

            const SizedBox(height: 14),

            // Aktivite kartı 2
            _activityCard(
              leadingEmoji: "🏅",
              title: "Hızlı Okuyucu Rozeti\nKazanıldı",
              subtitle: "Dün, 18:05",
              iconBg: AppColors.yellow,
              rightIcon: Icons.check_circle,
            ),
          ],
        ),
      ),
    );
  }

  // Aktivite kartını oluşturan yardımcı fonksiyon
  Widget _activityCard({
    required String leadingEmoji,
    required String title,
    required String subtitle,
    required Color iconBg,
    required IconData rightIcon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2F0DF)),
      ),
      child: Row(
        children: [
          // Sol ikon dairesi
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(leadingEmoji, style: const TextStyle(fontSize: 30)),
            ),
          ),

          const SizedBox(width: 16),

          // Yazı alanı
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.35,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8AB08C),
                  ),
                ),
              ],
            ),
          ),

          // Sağ kontrol ikonu
          Icon(rightIcon, color: Colors.green, size: 34),
        ],
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* CHILD LEARN */
/* ---------------------------------------------------------- */

// Çocuğun öğrenme ekranı
class ChildLearnPage extends StatelessWidget {
  const ChildLearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KidBgScaffold(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        child: Column(
          children: [
            // Sağ üst kapatma butonu
            const _TopCloseButton(),
            const SizedBox(height: 10),

            // Hayvan öğrenme kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              decoration: _mainCardDecoration(),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF2F4D6),
                    ),
                    child: const Center(
                      child: Text("🐶", style: TextStyle(fontSize: 110)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  _smallPill("HAYVANLAR", const Color(0xFFAED0FF)),
                  const SizedBox(height: 14),

                  const Text(
                    "Köpek",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "Hav hav! Bu tatlı arkadaşın ismi ne?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreen,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _bigButton(
                    text: "🎤  Söyle",
                    color: const Color(0xFF63EC7D),
                    textColor: const Color(0xFF0B5C23),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Renkler kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              decoration: _mainCardDecoration(),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF7F0C9),
                    ),
                    child: const Center(
                      child: Text("🎨", style: TextStyle(fontSize: 100)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  _smallPill("RENKLER", const Color(0xFF63EC7D)),
                  const SizedBox(height: 14),

                  const Text(
                    "Gökkuşağı",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "En sevdiğin renk hangisi?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreen,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Renk seçenekleri
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _colorDot(Color(0xFFC42A00)),
                      SizedBox(width: 14),
                      _colorDot(Color(0xFF0E6BB4)),
                      SizedBox(width: 14),
                      _colorDot(Color(0xFFF0D332)),
                      SizedBox(width: 14),
                      _colorDot(Color(0xFFA74349)),
                      SizedBox(width: 14),
                      _colorDot(Color(0xFF31A944), plus: true),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Güneş kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              decoration: _mainCardDecoration(),
              child: Column(
                children: [
                  // Sağ ve sol gezinme ikonları
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.chevron_left,
                          color: Color(0xFF7A6500),
                        ),
                      ),
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.chevron_right,
                          color: Color(0xFF7A6500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Görsel alan
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E3600), Color(0xFFFFB400)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Center(
                      child: Text("☀️", style: TextStyle(fontSize: 120)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    "GÜNEŞ",
                    style: TextStyle(
                      fontSize: 58,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF7A6500),
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "The Sun",
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF2C8A3A),
                    ),
                  ),
                  const SizedBox(height: 22),

                  _bigButton(
                    text: "🔊  Dinle",
                    color: AppColors.yellow,
                    textColor: const Color(0xFF5A4700),
                    onTap: () {},
                  ),
                  const SizedBox(height: 22),

                  // Alt bilgi kutuları
                  Row(
                    children: const [
                      Expanded(
                        child: _miniInfoCard(
                          color: Color(0xFFAED0FF),
                          icon: Icons.wb_sunny_outlined,
                          title: "Gündüz",
                          sub: "Daytime",
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: _miniInfoCard(
                          color: Color(0xFFFFACAC),
                          icon: Icons.wb_sunny,
                          title: "Sıcak",
                          sub: "Hot",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* PARENT SHELL */
/* ---------------------------------------------------------- */

// Ebeveyn ekranlarının ana kabuğu
// Alt menü ile farklı ebeveyn sayfaları açılır
class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  // Seçili sekme index'i
  int selectedIndex = 0;

  // Alt menüdeki ebeveyn sayfaları
  final List<Widget> pages = const [
    ParentDashboardPage(),
    ParentTrackingPage(),
    ParentSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      // Seçilen index'e göre ilgili sayfa açılır
      body: pages[selectedIndex],

      // Ebeveyn alt menüsü
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.97),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _parentBottomItem(
              index: 0,
              current: selectedIndex,
              icon: Icons.dashboard_rounded,
              label: 'Dashboard',
              onTap: () => setState(() => selectedIndex = 0),
            ),
            _parentBottomItem(
              index: 1,
              current: selectedIndex,
              icon: Icons.show_chart_rounded,
              label: 'Takip',
              onTap: () => setState(() => selectedIndex = 1),
            ),
            _parentBottomItem(
              index: 2,
              current: selectedIndex,
              icon: Icons.settings_rounded,
              label: 'Ayarlar',
              onTap: () => setState(() => selectedIndex = 2),
            ),
          ],
        ),
      ),
    );
  }

  // Ebeveyn alt menü öğesi
  Widget _parentBottomItem({
    required int index,
    required int current,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isActive = index == current;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEAF8F7) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF0A7D7E)
                  : const Color(0xFF9AA4B2),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isActive
                    ? const Color(0xFF0A7D7E)
                    : const Color(0xFF9AA4B2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* PARENT DASHBOARD */
/* ---------------------------------------------------------- */

// Ebeveyn ana panel ekranı
class ParentDashboardPage extends StatelessWidget {
  const ParentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst başlık alanı
              const _ParentTopHeader(title: "Ebeveyn Kontrolü"),
              const SizedBox(height: 26),

              // Karşılama başlığı
              const Text(
                "Merhaba, Deniz’in\nAnnesi",
                style: TextStyle(
                  fontSize: 34,
                  height: 1.15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF22242A),
                ),
              ),
              const SizedBox(height: 14),

              // Açıklama metni
              const Text(
                "Deniz bugün harika bir ilerleme kaydetti! Haftalık hedefine ulaşmak için sadece 3 ünite kaldı.",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Color(0xFF646B75),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),

              // Haftalık hedef kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                decoration: _parentCardDecoration(),
                child: Column(
                  children: [
                    // Büyük dairesel ilerleme alanı
                    SizedBox(
                      width: 260,
                      height: 260,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 260,
                            height: 260,
                            child: CircularProgressIndicator(
                              value: 0.75,
                              strokeWidth: 16,
                              backgroundColor: const Color(0xFFE4E8EB),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF0A7D7E),
                              ),
                            ),
                          ),

                          // Orta içerik
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE7F3F6),
                                ),
                                child: const Center(
                                  child: Text(
                                    "👶",
                                    style: TextStyle(fontSize: 48),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1C67D),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Text(
                                  "HAFTALIK HEDEF",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF7C5400),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              const Text(
                                "75%",
                                style: TextStyle(
                                  fontSize: 46,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF0A7D7E),
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    const Text(
                      "Deniz bu hafta toplam 4.5 saat çalıştı. Mevcut tempoyla Pazar günkü hedefine ulaşacak.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.55,
                        color: Color(0xFF4C5560),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Küçük bilgi kartları
              Row(
                children: const [
                  Expanded(
                    child: _ParentMiniStatCard(
                      title: "Öğrenilen\n342 Kelime",
                      color: Color(0xFFD8F4F4),
                      textColor: Color(0xFF0A7D7E),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _ParentMiniStatCard(
                      title: "Haftalık Seri\n5 Gün",
                      color: Color(0xFFF8EED8),
                      textColor: Color(0xFF9A6A00),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Dil gelişim puanı kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A7D7E),
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFF8DE6E4),
                      child: Icon(Icons.star_rounded, color: Color(0xFF0A7D7E)),
                    ),
                    const SizedBox(height: 18),

                    const Text(
                      "Dil Gelişim Puanı",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "Yaş grubundaki akranlarından %15 daha hızlı ilerliyor.",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Color(0xFFD8F4F4),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "860",
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        minHeight: 12,
                        value: 0.86,
                        backgroundColor: Color(0x338DE6E4),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF8DE6E4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // İki kutulu metrik alanı
              Row(
                children: const [
                  Expanded(
                    child: _ParentMetricBox(
                      icon: Icons.menu_book_rounded,
                      title: "Kazanılan Kelimeler",
                      value: "128",
                      color: Color(0xFFF4EAC7),
                      valueColor: Color(0xFF7A6500),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _ParentMetricBox(
                      icon: Icons.check_circle_outline_rounded,
                      title: "Tamamlanan Görevler",
                      value: "12",
                      color: Color(0xFF69F28A),
                      valueColor: Color(0xFF0A5B20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Geniş metrik kutusu
              const _ParentMetricWideBox(
                icon: Icons.schedule_rounded,
                title: "Günlük Kullanım",
                value: "45 dk",
                color: Color(0xFFAED0FF),
                valueColor: AppColors.blue,
              ),

              const SizedBox(height: 22),

              // Son aktiviteler başlığı
              _parentSectionTitle("Son Aktiviteler", "Hepsini Gör"),
              const SizedBox(height: 12),

              // Aktivite kartları
              const _ParentActivityCard(
                emoji: "🐾",
                title: "Hayvanlar\nÜnitesi\nTamamlandı",
                subtitle: "Deniz 20 yeni hayvan ismini %100 başarıyla öğrendi.",
                time: "2 saat\nönce",
                color: Color(0xFFAED0FF),
              ),
              const SizedBox(height: 14),

              const _ParentActivityCard(
                emoji: "🏅",
                title: "Hızlı Okuyucu\nRozeti Kazanıldı",
                subtitle: "Okuma hızı geçen haftaya göre %15 oranında arttı.",
                time: "5 saat\nönce",
                color: Color(0xFFF1C67D),
              ),

              const SizedBox(height: 18),

              // Haftalık ipucu kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A7592),
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.lightbulb_rounded,
                        size: 110,
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Haftalık İpucu",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "\"Görselleştirme tekniği, çocukların yeni kelimeleri %40 daha hızlı ezberlemesini sağlar. Bugün Deniz ile beraber öğrendiği hayvanların resmini çizebilirsiniz.\"",
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.7,
                            color: Color(0xFFE7F1F8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* PARENT TRACKING */
/* ---------------------------------------------------------- */

// Ebeveynin takip ekranı
// Grafikler ve kategori ilerlemeleri burada gösterilir
class ParentTrackingPage extends StatelessWidget {
  const ParentTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ParentTopHeader(title: "Ebeveyn Kontrolü"),
              const SizedBox(height: 24),

              // Haftalık öğrenim başlığı
              _parentSectionTitle(
                "Haftalık Kelime\nÖğrenimi",
                "SON 7\nGÜN",
                pill: true,
              ),
              const SizedBox(height: 14),

              // Sütun grafik kartı
              Container(
                width: double.infinity,
                height: 260,
                padding: const EdgeInsets.all(20),
                decoration: _parentCardDecoration(),
                child: Column(
                  children: [
                    const Expanded(
                      child: _WeeklyBarsChart(),
                    ),
                    const SizedBox(height: 14),

                    // Gün isimleri
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Pzt",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                        Text("Sal",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                        Text("Çar",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                        Text("Per",
                            style: TextStyle(
                              color: Color(0xFF0A7D7E),
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            )),
                        Text("Cum",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                        Text("Cmt",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                        Text("Paz",
                            style: TextStyle(
                                color: Color(0xFF6D747C), fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Trend grafiği başlığı
              _parentSectionTitle("Dil Gelişim Trendi", "AYLIK", pill: true),
              const SizedBox(height: 14),

              // Çizgi grafik kartı
              Container(
                width: double.infinity,
                height: 330,
                padding: const EdgeInsets.all(20),
                decoration: _parentCardDecoration(),
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10),
                        child: _LineTrendChart(),
                      ),
                    ),

                    // Grafik üzerindeki bilgi etiketi
                    Positioned(
                      right: 30,
                      top: 94,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Zirve: 92 Puan",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF8A6700),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Kategori başlığı
              const Text(
                "Kategori Detayları",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF22242A),
                ),
              ),
              const SizedBox(height: 14),

              // Kategori ilerleme kartları
              const _CategoryProgressCard(
                emoji: "🐾",
                title: "Hayvanlar",
                sub: "24/30 Kelime Öğrenildi",
                percent: 0.80,
                percentText: "80%",
                barColor: Color(0xFF4A7592),
                iconBg: Color(0xFFAED0FF),
              ),
              const SizedBox(height: 14),

              const _CategoryProgressCard(
                emoji: "🎨",
                title: "Renkler",
                sub: "12/15 Kelime Öğrenildi",
                percent: 0.80,
                percentText: "80%",
                barColor: Color(0xFF0A7D7E),
                iconBg: Color(0xFF8DE6E4),
              ),
              const SizedBox(height: 14),

              const _CategoryProgressCard(
                emoji: "🍎",
                title: "Meyveler",
                sub: "8/20 Kelime Öğrenildi",
                percent: 0.40,
                percentText: "40%",
                barColor: Color(0xFF9A6A00),
                iconBg: Color(0xFFF1C67D),
              ),

              const SizedBox(height: 18),

              // En çok tekrar edilenler kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                decoration: _parentCardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "En Çok Tekrar Edilenler",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF22242A),
                      ),
                    ),
                    const SizedBox(height: 18),

                    _repeatRow("01", "Köpek / Dog", "42 kez"),
                    _repeatRow("02", "Elma / Apple", "38 kez"),
                    _repeatRow("03", "Mavi / Blue", "29 kez"),
                    _repeatRow("04", "Kedi / Cat", "21 kez"),

                    const SizedBox(height: 20),

                    // Rapor indirme butonu
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A7D7E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "↓  TAM RAPORU İNDİR",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tekrar edilen kelimeler tablosundaki satırı oluşturan yardımcı fonksiyon
  Widget _repeatRow(String no, String word, String count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            children: [
              // Sıra numarası
              SizedBox(
                width: 54,
                child: Text(
                  no,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC7DFE0),
                  ),
                ),
              ),

              // Kelime
              Expanded(
                child: Text(
                  word,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF22242A),
                  ),
                ),
              ),

              // Sayaç
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  count,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF33363B),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE7EBEF)),
        ],
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* PARENT SETTINGS */
/* ---------------------------------------------------------- */

// Ebeveyn ayarlar ekranı
class ParentSettingsPage extends StatelessWidget {
  const ParentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ParentTopHeader(title: "Ebeveyn Kontrolü"),
              const SizedBox(height: 26),

              const Text(
                "KONTROL PANELİ",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A7D7E),
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Hoş geldiniz, Elif Hanım",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF22242A),
                ),
              ),
              const SizedBox(height: 12),

              const Text(
                "Çocuğunuzun dil öğrenme yolculuğunu buradan yönetebilirsiniz.",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Color(0xFF646B75),
                ),
              ),

              const SizedBox(height: 24),

              // Ekran süresi kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: _parentCardDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFFE6F1F2),
                          child: Icon(
                            Icons.timer_outlined,
                            color: Color(0xFF0A7D7E),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ekran Süresi Sınırı",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF22242A),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Günlük kullanım limitini belirleyin",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF646B75),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Aç/kapat anahtarı
                        Switch(
                          value: true,
                          onChanged: (_) {},
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF0A7D7E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Süre seçme alanı
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F4F5),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SÜRE SEÇİMİ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0A7D7E),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "45 Dakika",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF22242A),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Azalt ve artır butonları
                          _circleActionButton(Icons.remove),
                          const SizedBox(width: 12),
                          _circleActionButton(Icons.add, teal: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Günlük görev sayısı kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: _parentCardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFFF7F0E3),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: Color(0xFF9A6A00),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Günlük Görev Sayısı",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF22242A),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Tamamlanması gereken minimum hedef",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF646B75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text(
                          "Hedef: 5 Görev",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF44484E),
                          ),
                        ),
                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1C67D),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            "Önerilen",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF8C5C00),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Görev sayısı slider'ı
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFF1C67D),
                        inactiveTrackColor: const Color(0xFFE7D7B2),
                        thumbColor: const Color(0xFF9A6A00),
                        trackHeight: 6,
                      ),
                      child: Slider(
                        value: 5,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (_) {},
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Text(
                            "1 GÖREV",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B9199),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "10 GÖREV",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8B9199),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Özel görev belirleme kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A7D7E),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.star_rounded,
                        size: 120,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Özel Görev Belirle",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            "Çocuğunuz için bugün öğrenmesini istediğiniz özel kelimeleri veya cümleleri tanımlayın.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.6,
                              color: Color(0xFFD8F4F4),
                            ),
                          ),
                          const SizedBox(height: 22),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "Yeni Görev Ekle  →",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0A7D7E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Liste şeklinde ayar seçenekleri
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(0),
                decoration: _parentCardDecoration(),
                child: Column(
                  children: const [
                    _SettingsItem(
                      title: "Bildirim Ayarları",
                      sub: "Raporlar ve hatırlatıcıları yönetin",
                      icon: Icons.notifications_none_rounded,
                    ),
                    Divider(height: 1, color: Color(0xFFE8ECEF)),
                    _SettingsItem(
                      title: "Profil Düzenleme",
                      sub: "Ebeveyn ve çocuk bilgilerini güncelleyin",
                      icon: Icons.manage_accounts_outlined,
                    ),
                    Divider(height: 1, color: Color(0xFFE8ECEF)),
                    _SettingsItem(
                      title: "Gizlilik ve Güvenlik",
                      sub: "Veri yönetimi ve gizlilik politikası",
                      icon: Icons.info_outline_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // En alttaki bilgilendirme kutusu
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCECF6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFC7DFEE)),
                ),
                child: const Text(
                  "Tüm ayarlar KidLingua bulut hesabınızla senkronize edilir ve çocuğunuzun cihazında anında aktif olur.",
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.7,
                    color: Color(0xFF4A6478),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Artı ve eksi için dairesel buton oluşturan yardımcı widget
  Widget _circleActionButton(IconData icon, {bool teal = false}) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E7EA)),
      ),
      child: Icon(
        icon,
        color: teal ? const Color(0xFF0A7D7E) : const Color(0xFF858D96),
        size: 28,
      ),
    );
  }
}

/* ---------------------------------------------------------- */
/* PARENT HELPERS */
/* ---------------------------------------------------------- */

// Ebeveyn ekranlarında üstte görünen ortak başlık alanı
class _ParentTopHeader extends StatelessWidget {
  final String title;
  const _ParentTopHeader({required this.title});

  // Sağ üstteki X ile rol seçim ekranına geri döner
  void _goToRoleSelection(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const RoleSelectionScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sol taraftaki profil dairesi
        Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Text("👩", style: TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(width: 12),

        // Başlık
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A7D7E),
          ),
        ),
        const Spacer(),

        // Bildirim ikonu
        const Icon(
          Icons.notifications_none_rounded,
          color: Color(0xFF6A717B),
          size: 30,
        ),
        const SizedBox(width: 12),

        // Kapatma butonu
        GestureDetector(
          onTap: () => _goToRoleSelection(context),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.close, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

// Bölüm başlığı oluşturan yardımcı fonksiyon
Widget _parentSectionTitle(String title, String right, {bool pill = false}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            height: 1.3,
            fontWeight: FontWeight.w900,
            color: Color(0xFF22242A),
          ),
        ),
      ),

      // Sağ tarafta ister normal yazı ister etiket görünümü gösterilir
      pill
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD8F4F4),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                right,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A7D7E),
                  fontSize: 16,
                ),
              ),
            )
          : Text(
              right,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0A7D7E),
              ),
            ),
    ],
  );
}

// Ebeveyn kartları için ortak dekorasyon
BoxDecoration _parentCardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(34),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

// Küçük istatistik kartı
class _ParentMiniStatCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;

  const _ParentMiniStatCard({
    required this.title,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.8)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          height: 1.45,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),
      ),
    );
  }
}

// Kareye yakın metrik kutusu
class _ParentMetricBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Color valueColor;

  const _ParentMetricBox({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: valueColor, size: 30),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4C5560),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Geniş metrik kutusu
class _ParentMetricWideBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final Color valueColor;

  const _ParentMetricWideBox({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Icon(icon, color: valueColor, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4C5560),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Son aktiviteler kartı
class _ParentActivityCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String time;
  final Color color;

  const _ParentActivityCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _parentCardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF22242A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    color: Color(0xFF6A717B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Text(
            time,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6A717B),
            ),
          ),
        ],
      ),
    );
  }
}

// Kategori ilerleme kartı
class _CategoryProgressCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String sub;
  final double percent;
  final String percentText;
  final Color barColor;
  final Color iconBg;

  const _CategoryProgressCard({
    required this.emoji,
    required this.title,
    required this.sub,
    required this.percent,
    required this.percentText,
    required this.barColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _parentCardDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 34)),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF22242A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sub,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xFF6A717B),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                percentText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: barColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent,
              backgroundColor: const Color(0xFFE3E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Ayar listesi elemanı
class _SettingsItem extends StatelessWidget {
  final String title;
  final String sub;
  final IconData icon;

  const _SettingsItem({
    required this.title,
    required this.sub,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xFFF1F4F5),
        child: Icon(icon, color: const Color(0xFF7D8794), size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF22242A),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          sub,
          style: const TextStyle(
            fontSize: 17,
            color: Color(0xFF6A717B),
          ),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFFA1A8B1),
      ),
    );
  }
}

// Haftalık sütun grafiği
class _WeeklyBarsChart extends StatelessWidget {
  const _WeeklyBarsChart();

  @override
  Widget build(BuildContext context) {
    // Her gün için sütun yükseklikleri
    final heights = [70.0, 110.0, 90.0, 150.0, 80.0, 120.0, 170.0];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isActive = index == 3; // Perşembe aktif gibi gösteriliyor
        return Container(
          width: 26,
          height: heights[index],
          decoration: BoxDecoration(
            color:
                isActive ? const Color(0xFF0A7D7E) : const Color(0xFFBFECEC),
            borderRadius: BorderRadius.circular(16),
          ),
        );
      }),
    );
  }
}

// Çizgi grafik widget'ı
class _LineTrendChart extends StatelessWidget {
  const _LineTrendChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(),
      child: const SizedBox.expand(),
    );
  }
}

// Çizgi grafiği çizen custom painter
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Izgara çizgileri için paint
    final gridPaint = Paint()
      ..color = const Color(0xFFEAECEF)
      ..strokeWidth = 1;

    // Yatay yardımcı çizgiler
    for (int i = 1; i < 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Eğri çizgi yolu
    final path = Path();
    path.moveTo(10, size.height - 30);
    path.quadraticBezierTo(
      size.width * 0.18,
      size.height - 80,
      size.width * 0.32,
      size.height - 70,
    );
    path.quadraticBezierTo(
      size.width * 0.48,
      size.height - 20,
      size.width * 0.58,
      size.height - 120,
    );
    path.quadraticBezierTo(
      size.width * 0.70,
      size.height - 230,
      size.width * 0.82,
      size.height - 110,
    );
    path.quadraticBezierTo(
      size.width * 0.92,
      size.height - 10,
      size.width - 12,
      30,
    );

    // Çizginin altını doldurmak için alan yolu
    final fillPath = Path.from(path)
      ..lineTo(size.width - 12, size.height)
      ..lineTo(10, size.height)
      ..close();

    // Alt gölgelendirme
    final fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x33DDBA78),
          Color(0x11DDBA78),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Ana çizgi için paint
    final linePaint = Paint()
      ..color = const Color(0xFF9A6A00)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/* ---------------------------------------------------------- */
/* COMMON WIDGETS */
/* ---------------------------------------------------------- */

// Çocuk ekranlarında kullanılan ortak arka plan scaffold'ı
class KidBgScaffold extends StatelessWidget {
  final Widget child;

  const KidBgScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Çocuk ekranları için arka plan gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDDF8D8), Color(0xFFCFF3C8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(child: child),
      ),
    );
  }
}

// Sağ üstte kullanılan kapatma butonu
class _TopCloseButton extends StatelessWidget {
  final bool compact;
  const _TopCloseButton({this.compact = false});

  // Tıklandığında rol seçim ekranına döner
  void _goToRoleSelection(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const RoleSelectionScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => _goToRoleSelection(context),
        child: Container(
          width: compact ? 46 : 52,
          height: compact ? 46 : 52,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.close, color: Colors.black87, size: 30),
        ),
      ),
    );
  }
}

// Çocuk ekranlarında üst kısımda görünen küçük bar
class _TopBarSmall extends StatelessWidget {
  final String title;
  const _TopBarSmall({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sol emoji profil alanı
        Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Text("👦", style: TextStyle(fontSize: 30)),
          ),
        ),
        const SizedBox(width: 14),

        // Başlık
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF7A5A00),
          ),
        ),
        const Spacer(),

        // Seri/ateş ikonu
        const Icon(
          Icons.local_fire_department_rounded,
          color: AppColors.yellowDark,
          size: 30,
        ),
        const SizedBox(width: 10),

        // Kapatma butonu
        const _TopCloseButton(compact: true),
      ],
    );
  }
}

// Küçük bilgi kartı
class _miniInfoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String sub;

  const _miniInfoCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black54, size: 34),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// Renk noktası
class _colorDot extends StatelessWidget {
  final Color color;
  final bool plus;
  const _colorDot(this.color, {this.plus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: plus ? const Icon(Icons.add, color: Colors.white, size: 28) : null,
    );
  }
}

// Küçük etiket/pill widget'ı
Widget _smallPill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: color == AppColors.yellow
            ? const Color(0xFF5A4700)
            : const Color(0xFF255E95),
      ),
    ),
  );
}

// İçinde ikon da olan küçük buton/pill
Widget _iconButtonPill({
  required String label,
  required IconData icon,
  required Color color,
  required Color textColor,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

// Büyük ana buton widget'ı
Widget _bigButton({
  required String text,
  required Color color,
  required Color textColor,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 62,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    ),
  );
}

// Kare biçimli menü kartı
Widget _squareMenuCard({
  required Color color,
  required IconData icon,
  required Color iconColor,
  required String text,
  required Color textColor,
}) {
  return Container(
    height: 210,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: Colors.white.withOpacity(0.35),
          child: Icon(icon, color: iconColor, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

// Çocuk ekranlarında kullanılan ortak beyaz kart dekorasyonu
BoxDecoration _mainCardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(34),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.14),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  );
}