import 'dart:io';

void main() {
  stdout.write("Digite a expressão: ");
  String? entrada = stdin.readLineSync();

  if (entrada == null || entrada.isEmpty) return;

  try {
    double resultado = calcular(entrada);
    print("Resultado: $resultado");
  } catch (e) {
    print("Erro: Expressão inválida.");
  }
}

double calcular(String expressao) {
  List<String> tokens = [];
  String numeroAtual = "";

  for (int i = 0; i < expressao.length; i++) {
    String char = expressao[i];

    if ("+-*/".contains(char)) {
      tokens.add(numeroAtual);
      tokens.add(char);
      numeroAtual = "";
    } else {
      numeroAtual += char;
    }
  }

  tokens.add(numeroAtual);

  for (int i = 0; i < tokens.length; i++) {
    if (tokens[i] == "*" || tokens[i] == "/") {
      double a = double.parse(tokens[i - 1]);
      double b = double.parse(tokens[i + 1]);
      double resultado =
          tokens[i] == "*" ? a * b : a / b;

      tokens[i - 1] = resultado.toString();
      tokens.removeAt(i); // operador
      tokens.removeAt(i); // segundo número
      i--;
    }
  }

  double resultadoFinal = double.parse(tokens[0]);

  for (int i = 1; i < tokens.length; i += 2) {
    String operador = tokens[i];
    double numero = double.parse(tokens[i + 1]);

    if (operador == "+") {
      resultadoFinal += numero;
    } else {
      resultadoFinal -= numero;
    }
  }

  return resultadoFinal;
}
