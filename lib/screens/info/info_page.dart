import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String infoText = '';

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('သိမှတ်ဖွယ်'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HtmlWidget(
            infoText,
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _loadInfo() {
    DefaultAssetBundle.of(context)
        .loadString('assets/info.html')
        .then((value) => setState(() => infoText = value));
  }
}
