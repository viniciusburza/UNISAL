import 'package:roguelike/entidade.dart';
import 'package:roguelike/ponto_2d.dart';
import 'package:roguelike/mundo.dart';

// Classe Criatura é derivada (filha) da classe Personagem
class Moeda extends Entidade {
  // Constantes
  static final String SIMBOLO_MOEDA = "G";

  // Construtor padrão + Construtor do pai (super)
  Moeda(Ponto2D posicao, String simbolo) : super(posicao, simbolo);
}
