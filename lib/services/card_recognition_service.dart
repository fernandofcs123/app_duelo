import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CardRecognitionService {
  final TextRecognizer _textRecognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  Future<String?> reconhecerCodigo(String caminhoImagem) async {
    final imagem = InputImage.fromFilePath(caminhoImagem);
    final resultado = await _textRecognizer.processImage(imagem);
    
    final codigosEncontrados = <String>{};

    final linhas = resultado.text.split(RegExp(r'[\r\n]+'));

    final regexCodigo = RegExp(
      r'(?:^|[^\d])((?:\d[\s.-]*){7}\d)(?:$|[^\d])',
    );

    for (final linha in linhas) {
      for (final correspondencia in regexCodigo.allMatches(linha)) {
        final trecho = correspondencia.group(1);

        if (trecho == null) continue;

        final codigo = trecho.replaceAll(RegExp(r'\D'), '');

        if (RegExp(r'^\d{8}$').hasMatch(codigo)) {
          codigosEncontrados.add(codigo);
        }
      }
    }

    if(codigosEncontrados.length != 1) {
      return null;
    }

    return codigosEncontrados.first;
  }

  void dispose() {
    _textRecognizer.close();
  }
}