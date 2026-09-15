import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Layanan Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
      ),
      home: const BerandaScreen(),
    );
  }
}

class KatalogItem {
  final int id;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final IconData icon;
  final Color warnaPastel;
  final List<String> keahlian;
  final double rating;

  const KatalogItem({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.icon,
    required this.warnaPastel,
    required this.keahlian,
    required this.rating,
  });

  String get formattedHarga {
    final str = harga.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }
}

final List<KatalogItem> daftarKatalog = const [
  KatalogItem(
    id: 1,
    nama: 'Desain UI/UX Mobile App',
    kategori: 'Desain & Kreatif',
    harga: 350000,
    deskripsi:
        'Layanan pembuatan desain UI/UX interaktif berbasis Figma dengan standar modern, sistem komponen reusable, dan alur pengalaman pengguna yang intuitif untuk platform iOS & Android.',
    icon: Icons.palette_outlined,
    warnaPastel: Color(0xFFE8F4FD),
    keahlian: ['Figma', 'Wireframing', 'Design System', 'Prototyping'],
    rating: 4.9,
  ),
  KatalogItem(
    id: 2,
    nama: 'Pengembangan Web Fullstack',
    kategori: 'Web Development',
    harga: 750000,
    deskripsi:
        'Jasa pembuatan website responsif dan cepat menggunakan Flutter Web / Next.js dan backend REST API terintegrasi database dengan proteksi keamanan tinggi serta performa optimal.',
    icon: Icons.code_rounded,
    warnaPastel: Color(0xFFF3E8FF),
    keahlian: ['Flutter', 'Node.js', 'PostgreSQL', 'REST API'],
    rating: 4.8,
  ),
  KatalogItem(
    id: 3,
    nama: 'Optimasi SEO & Digital Ads',
    kategori: 'Pemasaran Digital',
    harga: 250000,
    deskripsi:
        'Audit performa web komprehensif, riset kata kunci potensial, optimasi halaman on-page/off-page, dan strategi periklanan terarah guna mendongkrak visibilitas bisnis secara organik.',
    icon: Icons.trending_up_rounded,
    warnaPastel: Color(0xFFE6F4EA),
    keahlian: ['SEO Audit', 'Google Analytics', 'Copywriting', 'Meta Ads'],
    rating: 4.7,
  ),
];

/// Screen 1 (Beranda) - Wajib StatelessWidget
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Layanan Digital',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: daftarKatalog.length,
        itemBuilder: (context, index) {
          final item = daftarKatalog[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: item.warnaPastel,
                child: Icon(
                  item.icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
              title: Text(
                item.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item.kategori,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.formattedHarga,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKatalogScreen(katalog: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Screen 2 (Detail Katalog) - Wajib StatefulWidget & Column layout
class DetailKatalogScreen extends StatefulWidget {
  final KatalogItem katalog;

  const DetailKatalogScreen({super.key, required this.katalog});

  @override
  State<DetailKatalogScreen> createState() => _DetailKatalogScreenState();
}

class _DetailKatalogScreenState extends State<DetailKatalogScreen> {
  bool _isFavorit = false;
  int _jumlahItem = 1;
  bool _pesananDikonfirmasi = false;

  void _toggleFavorit() {
    setState(() {
      _isFavorit = !_isFavorit;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorit
              ? '${widget.katalog.nama} ditambahkan ke Favorit.'
              : '${widget.katalog.nama} dihapus dari Favorit.',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _tambahItem() {
    setState(() {
      _jumlahItem++;
    });
  }

  void _kurangItem() {
    if (_jumlahItem > 1) {
      setState(() {
        _jumlahItem--;
      });
    }
  }

  void _konfirmasiPesanan() {
    setState(() {
      _pesananDikonfirmasi = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pesanan untuk "${widget.katalog.nama}" sejumlah $_jumlahItem berhasil dikonfirmasi!',
        ),
        backgroundColor: Colors.teal.shade700,
      ),
    );
  }

  String _formatKalkulasi(int nilai) {
    final str = nilai.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }

  @override
  Widget build(BuildContext context) {
    final totalHarga = widget.katalog.harga * _jumlahItem;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Katalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Kembali ke Screen 1',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorit ? Icons.favorite : Icons.favorite_border,
              color: _isFavorit ? Colors.red : null,
            ),
            tooltip: _isFavorit ? 'Hapus Favorit' : 'Tambah Favorit',
            onPressed: _toggleFavorit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: widget.katalog.warnaPastel,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.katalog.icon,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.katalog.nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.katalog.kategori,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  widget.katalog.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.katalog.formattedHarga,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: widget.katalog.warnaPastel,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.06),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Deskripsi Singkat Layanan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 18),
                  Text(
                    widget.katalog.deskripsi,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Keahlian & Fitur Termasuk:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: widget.katalog.keahlian.map((fitur) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.08),
                          ),
                        ),
                        child: Text(
                          fitur,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pemesanan (Event & State Management)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Jumlah Paket/Layanan:',
                          style: TextStyle(fontSize: 14),
                        ),
                        Row(
                          children: [
                            IconButton.filledTonal(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: _jumlahItem > 1 ? _kurangItem : null,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                '$_jumlahItem',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton.filledTonal(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: _tambahItem,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Biaya:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatKalkulasi(totalHarga),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _konfirmasiPesanan,
                        icon: Icon(
                          _pesananDikonfirmasi
                              ? Icons.check_circle
                              : Icons.shopping_bag_outlined,
                        ),
                        label: Text(
                          _pesananDikonfirmasi
                              ? 'Pesanan Berhasil Dikonfirmasi'
                              : 'Pesan Sekarang',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _pesananDikonfirmasi
                              ? Colors.teal
                              : Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Beranda (Screen 1)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
