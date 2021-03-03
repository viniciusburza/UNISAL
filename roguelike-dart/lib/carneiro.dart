import 'dart:math';
import 'package:roguelike/mundo.dart';
import 'package:roguelike/personagem.dart';
import 'package:roguelike/ponto_2d.dart';

// Classe Criatura é derivada (filha) da classe Personagem
class Carneiro extends Personagem {
  // Constantes
  static final int FICAR_PARADO = 0;
  static final int MOVER_BAIXO = 1;
  static final int MOVER_CIMA = 2;
  static final int MOVER_DIREITA = 3;
  static final int MOVER_ESQUERDA = 4;
  static final int QUANTIDADE_MOVIMENTOS = 5;
  static final String SIMBOLO_CARNEIRO = "C";

  // Variável privada para criar números aleatório
  Random _aleatorio;

  // Construtor padrão + Construtor do pai (super)
  Carneiro(Ponto2D posicao, String simbolo) : super(posicao, simbolo) {
    // Random(SEED)
    // SEED = NULL indica que vai pegar o tempo atual
    _aleatorio = Random(null);
  }

  // Implementação do método abstrato atualizar
  // @mundo: mundo em que o personagem esta no momento
  void atualizar(Mundo mundo) {
    if (posicao.x - mundo.jogador.posicao.x > 0) {
      //CARNEIRO ANDA ESQUERDA
      mover(mundo, 1, 0);
    } else if (posicao.x - mundo.jogador.posicao.x < 0) {
      //CARNEIRO ANDA DIREITA
      mover(mundo, -1, 0);
    } else if (posicao.y - mundo.jogador.posicao.y > 0) {
      //CARNEIRO ANDA DIREITA
      mover(mundo, 0, 1);
    } else if (posicao.y - mundo.jogador.posicao.y < 0) {
      //CARNEIRO ANDA DIREITA
      mover(mundo, 0, -1);
    }
  }
}
