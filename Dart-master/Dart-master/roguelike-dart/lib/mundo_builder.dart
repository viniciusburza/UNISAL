import 'dart:math';
import 'package:roguelike/celula.dart';
import 'package:roguelike/criatura.dart';
import 'package:roguelike/lobo.dart';
import 'package:roguelike/carneiro.dart';
import 'package:roguelike/moeda.dart';
import 'package:roguelike/mundo.dart';
import 'package:roguelike/ponto_2d.dart';

// Classe que criará mundos seguindo o padrão Builder
class MundoBuilder {
  // Constantes
  static final String SIMBOLO_PASSAGEM = "_";

  // Variáveis
  int largura, altura;
  List<List<Celula>> mapa;
  List<Criatura> criaturas;
  List<Lobo> lobos;
  List<Carneiro> carneiros;
  List<Moeda> moedas;

  // Construtor padrão
  MundoBuilder(this.largura, this.altura) {
    criaturas = [];
    lobos = [];
    carneiros = [];
    moedas = [];
  }

  // Método para preencher o mapa (passo 1 da heurística)
  MundoBuilder preencher(String simbolo, bool bloqueado) {
    // Cria uma matriz X, Y com Células
    mapa = List.generate(
        largura,
        (int x) => List.generate(
            altura, (int y) => Celula(Ponto2D(x, y), simbolo, bloqueado)));
    return this;
  }

  // Método para criar o caminho (passagem)
  // @x : início do personagem na posição X
  // @y : início do personagem na posição Y
  // @passos : quantidade de passos para o personagem sergui a bússola
  MundoBuilder criarCaminho(int x, int y, int passos) {
    // Inicia a bússola quebrada (gerador de número aleatório)
    Random bussola = Random(null);
    // Realiza os K passados
    for (int i = 0; i < passos; i++) {
      // Verifica o novo norte da heurístíca
      var norte = bussola.nextInt(4);

      // Desloca o jogador para o norte apontado (sem atravessar as paredes)
      if (norte == 0 && (x + 1) < (largura - 1)) {
        x += 1;
      } else if (norte == 1 && (x - 1) > 0) {
        x -= 1;
      } else if (norte == 2 && (y + 1) < (altura - 1)) {
        y += 1;
      } else if (norte == 3 && (y - 1) > 0) y -= 1;

      // Troca a parede por uma passagem
      mapa[x][y] = Celula(Ponto2D(x, y), SIMBOLO_PASSAGEM, false);
    }

    return this;
  }

  // Método que adiciona criaturas no mapa
  // @quantidadeCriaturas : número de criaturas que queremos colocar no mapa
  MundoBuilder criarCriaturas(int quantidadeCriaturas) {
    // cria um número aleatório
    Random aleatorio = Random();
    int x, y;
    // Cria N criaturas
    for (int i = 0; i < quantidadeCriaturas; i++) {
      // Impede que uma criatura seja criada em cima de uma parede
      do {
        x = aleatorio.nextInt(largura);
        y = aleatorio.nextInt(altura);
      } while (mapa[x][y].bloqueado);

      // Adiciona a criatura na lista de criaturas
      criaturas.add(Criatura(Ponto2D(x, y), Criatura.SIMBOLO_CRIATURA));
    }
    return this;
  }

  MundoBuilder criarLobos(int quantidadeLobos) {
    // cria um número aleatório
    Random aleatorio = Random();
    int x, y;
    // Cria N criaturas
    for (int i = 0; i < quantidadeLobos; i++) {
      // Impede que uma criatura seja criada em cima de uma parede
      do {
        x = aleatorio.nextInt(largura);
        y = aleatorio.nextInt(altura);
      } while (mapa[x][y].bloqueado);

      // Adiciona a criatura na lista de criaturas
      lobos.add(Lobo(Ponto2D(x, y), Lobo.SIMBOLO_LOBO));
    }
    return this;
  }

  MundoBuilder criarCarneiros(int quantidadeCarneiros) {
    // cria um número aleatório
    Random aleatorio = Random();
    int x, y;
    // Cria N criaturas
    for (int i = 0; i < quantidadeCarneiros; i++) {
      // Impede que uma criatura seja criada em cima de uma parede
      do {
        x = aleatorio.nextInt(largura);
        y = aleatorio.nextInt(altura);
      } while (mapa[x][y].bloqueado);

      // Adiciona a criatura na lista de criaturas
      carneiros.add(Carneiro(Ponto2D(x, y), Carneiro.SIMBOLO_CARNEIRO));
    }
    return this;
  }

  MundoBuilder criarMoedas(int quantidadeMoedas) {
    // cria um número aleatório
    Random aleatorio = Random();
    int x, y;
    // Cria N criaturas
    for (int i = 0; i < quantidadeMoedas; i++) {
      // Impede que uma criatura seja criada em cima de uma parede
      do {
        x = aleatorio.nextInt(largura);
        y = aleatorio.nextInt(altura);
      } while (mapa[x][y].bloqueado);

      // Adiciona a criatura na lista de criaturas
      moedas.add(Moeda(Ponto2D(x, y), Moeda.SIMBOLO_MOEDA));
    }
    return this;
  }

  // Retorna um Mundo
  Mundo build() {
    return Mundo(mapa, criaturas, lobos, carneiros, moedas);
  }
}
