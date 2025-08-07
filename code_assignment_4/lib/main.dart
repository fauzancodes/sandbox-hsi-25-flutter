import 'package:flutter/material.dart';

void main() {
  runApp(SantriApp());
}

class SantriApp extends StatelessWidget {
  const SantriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Pendaftaran Santri',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pendaftaran Santri HSI')),
      body: Center(
        child: ElevatedButton(
          child: Text('Mulai Daftar'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FormPage()),
            );
          },
        ),
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();

  String? _jenisKelamin;
  bool _setuju = false;
  bool _notifikasi = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _setuju) {
      String nama = _namaController.text;
      String kelamin = _jenisKelamin ?? 'Belum dipilih';
      String notifikasi = _notifikasi ? 'Ya' : 'Tidak';
      String setuju = _setuju ? 'Ya' : 'Tidak';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nama: $nama\nJenis Kelamin: $kelamin\nSetuju: $setuju\nNotifikasi: $notifikasi',
          ),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi nama dan centang persetujuan.')),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulir Pendaftaran')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Lengkap
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              SizedBox(height: 16),

              // Jenis Kelamin
              Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: Text('Laki-laki'),
                leading: Radio<String>(
                  value: 'Laki-laki',
                  groupValue: _jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Perempuan'),
                leading: Radio<String>(
                  value: 'Perempuan',
                  groupValue: _jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  },
                ),
              ),

              // Checkbox Persetujuan
              CheckboxListTile(
                title: Text('Saya bersedia mengikuti seluruh program'),
                value: _setuju,
                onChanged: (value) {
                  setState(() {
                    _setuju = value ?? false;
                  });
                },
              ),

              // Switch Notifikasi
              SwitchListTile(
                title: Text('Ingin menerima notifikasi pengingat'),
                value: _notifikasi,
                onChanged: (value) {
                  setState(() {
                    _notifikasi = value;
                  });
                },
              ),

              // Tombol Submit
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
