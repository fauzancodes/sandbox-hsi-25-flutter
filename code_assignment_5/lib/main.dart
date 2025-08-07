import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<String>('siswaBox');

  runApp(SiswaApp());
}

class SiswaApp extends StatelessWidget {
  const SiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Siswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();

  late Box<String> siswaBox;

  @override
  void initState() {
    super.initState();
    siswaBox = Hive.box<String>('siswaBox');

    if (siswaBox.isEmpty) {
      siswaBox.addAll(['Budi', 'Siti']);
    }
  }

  void _showTambahSiswaDialog() {
    _namaController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Siswa'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Siswa'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tidak boleh kosong';
                } else if (value.trim().length < 3) {
                  return 'Minimal 3 karakter';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  siswaBox.add(_namaController.text.trim());
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Siswa'),
      ),
      body: ValueListenableBuilder(
        valueListenable: siswaBox.listenable(),
        builder: (context, Box<String> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('Belum ada data siswa.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final nama = box.getAt(index);
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(nama ?? ''),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTambahSiswaDialog,
        tooltip: 'Tambah Siswa',
        child: Icon(Icons.add),
      ),
    );
  }
}
