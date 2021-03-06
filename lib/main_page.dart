import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'package:coinslib/coinslib.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ImagePicker _picker = ImagePicker();

  // final NetworkType _network = testnet;
  final NetworkType _network = bitcoin;

  HDWallet? _wallet;
  bool _isLoading = false;

  Future<List<String>> _imagesToHashes(List<XFile> images) {
    return Future.wait(images.map(
      (image) => _generateImageHash(File(image.path)),
    ));
  }

  Future<String> _generateImageHash(File file) async {
    var imageBytes = file.readAsBytesSync().toString();
    var bytes = utf8.encode(imageBytes);
    String digest = sha256.convert(bytes).toString();
    return digest;
  }

  HDWallet _createWalletFromHashes(List<String> hashes) {
    final phrase = hashes.join(" ");
    Uint8List seed = bip39.mnemonicToSeed(phrase);
    HDWallet hdWallet = HDWallet.fromSeed(seed, network: _network);
    return hdWallet;
  }

  Widget _buildLoading() {
    return const Center(
      child: Text('Loading wallet...'),
    );
  }

  Widget _buildContent() {
    if (_wallet == null) {
      return const Center(
        child: Text('No wallet setup, add photos to import a wallet'),
      );
    }

    return Scrollbar(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildItem('Pay-to-public-key-hash address', _wallet?.address ?? ''),
              _buildItem('Public key', _wallet?.pubKey ?? ''),
              _buildItem('Private key', _wallet?.privKey ?? ''),
              _buildItem('Wallet import format', _wallet?.wif ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return InkWell(
      onTap: () async {
        Clipboard.setData(ClipboardData(text: value)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title copied to clipboard')));
        });
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.black38)),
            Container(height: 8),
            Text(value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos to Bitcoin Wallet'),
      ),
      body: Builder(builder: (context) {
        return _isLoading ? _buildLoading() : _buildContent();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createWalletFromPhotos(),
        tooltip: 'Import Wallet',
        child: const Icon(Icons.account_balance_wallet),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _createWalletFromPhotos() async {
    setState(() {
      _isLoading = true;
    });

    final List<XFile>? images = await _picker.pickMultiImage();

    // Break if no photos added
    if (images == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final hashes = await _imagesToHashes(images);
    final wallet = _createWalletFromHashes(hashes);

    setState(() {
      _wallet = wallet;
      _isLoading = false;
    });
  }
}
