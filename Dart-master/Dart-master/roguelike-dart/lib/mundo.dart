import 'dart:math';
import 'package:roguelike/celula.dart';
import 'package:roguelike/criatura.dart';
import 'package:roguelike/entidade.dart';
import 'package:roguelike/lobo.dart';
import 'package:roguelike/carneiro.dart';
import 'package:roguelike/moeda.dart';
import 'package:roguelike/jogador.dart';
import 'package:roguelike/ponto_2d.dart';

// Classe que representa o mundo do jogo
class Mundo {
  // Variável privada que guarda a largura e altura do mundo
  int _largura, _altura;
  // Matriz de células (grade) que define o mapa
  List<List<Celula>> mapa;
  // Lista de criaturas (NPCs)
  List<Criatura> criaturas;
  // Lista de Lobos (NPCs)
  List<Lobo> lobos;
  // Lista de Carneiros (NPCs)
  List<Carneiro> carneiros;
  // Lista de Moedas
  List<Moeda> moedas;
  // Jogador controlado
  Jogador jogador;

  // Construtor padrão do mundo
  // @mapa: mapa criado de qualquer forma
  // @crituras: lista de criaturas posicionadas
  Mundo(this.mapa, this.criaturas, this.lobos, this.carneiros, this.moedas) {
    _largura = mapa.length;
    _altura = mapa[0].length;
  }

  // Método que verifica se uma posição X,Y do mapa esta bloqueada ou não
  bool bloqueado(int x, int y) {
    return mapa[x][y].bloqueado;
  }

  // Método que atualiza todas as criaturas do mundo
  void atualizar() {
    // Atualiza a posição do jogador
    // FOREACH: atualiza a posição de todas as criaturas
    for (Criatura criatura in criaturas) {
      // Atualiza a posição de uma criatura
      criatura.atualizar(this);

      // Se a posição de uma criatura for igual a posição do jogador
      if (criatura.posicao.toString() == jogador.posicao.toString()) {
        // jogador toma 1 de dano (perde uma vida)
        jogador.tomarDano(1);
      }
    }

    // FOREACH: atualiza a posição de todas os lobos
    for (Lobo lobo in lobos) {
      // Atualiza a posição de uma criatura

      // Se a posição de uma criatura for igual a posição do jogador
      if (lobo.posicao.toString() == jogador.posicao.toString()) {
        // jogador toma 1 de dano (perde uma vida)
        jogador.tomarDano(1);
        print("Você tomou DANO!");
      }
      lobo.atualizar(this);
    }

    // FOREACH: atualiza a posição de todas os carneiros
    for (Carneiro carneiro in carneiros) {
      // Atualiza a posição de uma criatura
      carneiro.atualizar(this);
    }

    if (moedas.any(
        (moeda) => moeda.posicao.toString() == jogador.posicao.toString())) {
      moedas.removeWhere(
          (moeda) => moeda.posicao.toString() == jogador.posicao.toString());
      var gold = (50 + (Random(null).nextInt(100 - 50)));
      jogador.ganharGold(gold);
      print("\nVocê achou um tesouro: + ${gold} moedas \n");
    }

    jogador.atualizar(this);
  }

  // Método para desenhar o mundo no console
  void desenhar() {
    // Criar um mapa de criaturas baseado em suas posições
    Map<String, Entidade> map = Map();
    for (Criatura creature in criaturas) {
      map[creature.posicao.toString()] = creature;
    }

    for (Lobo wolf in lobos) {
      map[wolf.posicao.toString()] = wolf;
    }

    for (Carneiro ram in carneiros) {
      map[ram.posicao.toString()] = ram;
    }

    for (Moeda gold in moedas) {
      map[gold.posicao.toString()] = gold;
    }

    // Adicionamos também o jogador no mapa
    map[jogador.posicao.toString()] = jogador;

    // Exibe informações do jogador
    print(
        "\nJogador está em [${jogador.posicao}] \t Vidas: ${jogador.vidas} \t Moedas: ${jogador.moedas} \t Passos: ${jogador.passos} \n");

    // Desenhar o mapa (percorre todas as linhas)
    for (int y = 0; y < _altura; y++) {
      var line = "";
      // Percorre todas as colunas
      for (int x = 0; x < _largura; x++) {
        // SE na posição X, Y existe algo além do chão, então
        if (map[Ponto2D(x, y).toString()] != null) {
          // SE a posição tem um jogador, desenha o jogador, caso contrário desenha a criatura
          if (map[Ponto2D(x, y).toString()].simbolo ==
              Jogador.SIMBOLO_JOGADOR) {
            line += '\u001b[35;1m' + map[Ponto2D(x, y).toString()].toString();
          } else if (map[Ponto2D(x, y).toString()].simbolo ==
              Criatura.SIMBOLO_CRIATURA) {
            line += '\u001b[32;1m' + map[Ponto2D(x, y).toString()].toString();
          } else if (map[Ponto2D(x, y).toString()].simbolo ==
              Lobo.SIMBOLO_LOBO) {
            line += '\u001b[31;1m' + map[Ponto2D(x, y).toString()].toString();
          } else if (map[Ponto2D(x, y).toString()].simbolo ==
              Carneiro.SIMBOLO_CARNEIRO) {
            line += '\u001b[36;1m' + map[Ponto2D(x, y).toString()].toString();
          } else {
            line += '\u001b[33;1m' + map[Ponto2D(x, y).toString()].toString();
          }
        } else {
          // Desenha o mapa
          line += '\u001b[0m' + mapa[x][y].toString();
        }
      }
      print(line);
    }
  }
}
