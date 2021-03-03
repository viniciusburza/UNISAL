import 'package:roguelike/mundo.dart';
import 'package:roguelike/personagem.dart';
import 'package:roguelike/ponto_2d.dart';

// Classe Criatura é derivada (filha) da classe Personagem
class Lobo extends Personagem {
  // Constantes
  static final int FICAR_PARADO = 0;
  static final int MOVER_BAIXO = 1;
  static final int MOVER_CIMA = 2;
  static final int MOVER_DIREITA = 3;
  static final int MOVER_ESQUERDA = 4;
  static final int QUANTIDADE_MOVIMENTOS = 5;
  static final String SIMBOLO_LOBO = "L";

  // Construtor padrão + Construtor do pai (super)
  Lobo(Ponto2D posicao, String simbolo) : super(posicao, simbolo) {}

  void atualizar(Mundo mundo) {
    if (posicao == mundo.jogador.posicao) {
      mover(mundo, 0, 0);
    } else if (posicao.x - mundo.jogador.posicao.x > 0) {
      mover(mundo, -1, 0);
    } else if (posicao.x - mundo.jogador.posicao.x < 0) {
      mover(mundo, 1, 0);
    } else if (posicao.y - mundo.jogador.posicao.y > 0) {
      mover(mundo, 0, -1);
    } else if (posicao.y - mundo.jogador.posicao.y < 0) {
      mover(mundo, 0, 1);
    }
  }
}
