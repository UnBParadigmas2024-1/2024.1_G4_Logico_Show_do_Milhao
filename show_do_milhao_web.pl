:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

:- dynamic jogador/1.
:- dynamic pontuacao/1.
:- dynamic valor_acumulado/1.
:- dynamic pergunta/4.

% Carregar perguntas e respostas
carregar_perguntas :-
    assertz(pergunta(1, 'Qual é a capital do Brasil?', ['a) Rio de Janeiro', 'b) Brasília', 'c) São Paulo', 'd) Salvador'], 'b')),
    assertz(pergunta(2, 'Qual é o maior planeta do Sistema Solar?', ['a) Terra', 'b) Marte', 'c) Júpiter', 'd) Saturno'], 'c')),
    assertz(pergunta(3, 'Quem pintou a Mona Lisa?', ['a) Vincent van Gogh', 'b) Leonardo da Vinci', 'c) Pablo Picasso', 'd) Michelangelo'], 'b')),
    assertz(pergunta(4, 'Em que ano o homem pisou na Lua pela primeira vez?', ['a) 1965', 'b) 1967', 'c) 1969', 'd) 1971'], 'c')),
    assertz(pergunta(5, 'Qual é o maior oceano do mundo?', ['a) Oceano Atlântico', 'b) Oceano Índico', 'c) Oceano Pacífico', 'd) Oceano Ártico'], 'c')),
    assertz(pergunta(6, 'Qual é o maior mamífero terrestre?', ['a) Elefante', 'b) Girafa', 'c) Hipopotamo', 'd) Rinoceronte'], 'a')),
    assertz(pergunta(7, 'Qual é a capital da França?', ['a) Paris', 'b) Lyon', 'c) Marseille', 'd) Toulouse'], 'a')),
    assertz(pergunta(8, 'Quem escreveu "Dom Casmurro"?', ['a) Machado de Assis', 'b) José de Alencar', 'c) Jorge Amado', 'd) Lima Barreto'], 'a')),
    assertz(pergunta(9, 'Qual é o elemento químico representado pelo símbolo Au?', ['a) Ouro', 'b) Prata', 'c) Alumínio', 'd) Cobre'], 'a')),
    assertz(pergunta(10, 'Qual planeta é conhecido como o "planeta vermelho"?', ['a) Marte', 'b) Vênus', 'c) Júpiter', 'd) Saturno'], 'a')),
    assertz(pergunta(11, 'Qual é o idioma oficial do Brasil?', ['a) Espanhol', 'b) Português', 'c) Inglês', 'd) Francês'], 'b')),
    assertz(pergunta(12, 'Em que ano foi fundada a cidade de São Paulo?', ['a) 1554', 'b) 1600', 'c) 1700', 'd) 1800'], 'a')),
    assertz(pergunta(13, 'Quem foi o primeiro presidente do Brasil?', ['a) Marechal Deodoro da Fonseca', 'b) Getúlio Vargas', 'c) Juscelino Kubitschek', 'd) Pedro II'], 'a')),
    assertz(pergunta(14, 'Qual é o menor estado brasileiro em termos de área?', ['a) São Paulo', 'b) Rio de Janeiro', 'c) Sergipe', 'd) Alagoas'], 'c')),
    assertz(pergunta(15, 'Qual é o maior rio do mundo em volume de água?', ['a) Nilo', 'b) Amazonas', 'c) Yangtze', 'd) Mississippi'], 'b')).

% Servidor Web
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- http_handler(root(.), http_reply_from_files('web', []), [prefix]).
:- http_handler(root(api/iniciar), iniciar_jogo, []).
:- http_handler(root(api/pergunta), enviar_pergunta, []).
:- http_handler(root(api/resposta), verificar_resposta, []).
:- http_handler(root(api/ajuda), fornecer_ajuda, []).
:- http_handler(root(api/desistir), desistir, []).

% Iniciar o jogo
iniciar_jogo(_Request) :-
    carregar_perguntas,
    retractall(jogador(_)),
    retractall(pontuacao(_)),
    retractall(valor_acumulado(_)),
    assertz(pontuacao(0)),
    assertz(valor_acumulado(0)),
    reply_json(_{status: 'Jogo iniciado'}).

% Enviar pergunta
enviar_pergunta(_Request) :-
    pontuacao(P),
    ProximaPergunta is P + 1,
    (pergunta(ProximaPergunta, Pergunta, Alternativas, _) ->
        reply_json(_{numero: ProximaPergunta, pergunta: Pergunta, alternativas: Alternativas});
        finalizar_jogo).

verificar_resposta(Request) :-
    catch(
        (   http_read_json_dict(Request, Dados),
            atom_string(AtomNumero, Dados.numero), % Converte para átomo
            atom_string(AtomResposta, Dados.resposta), % Converte para átomo
            atom_number(AtomNumero, Numero), % Converte átomo para número
            pergunta(Numero, _, _, RespostaCorreta),
            (AtomResposta = RespostaCorreta ->
                incrementar_pontuacao,
                reply_json(_{status: 'Correto'});
                reply_json(_{status: 'Errado', resposta_correta: RespostaCorreta}))
        ),
        Error,
        (   format(user_error, 'Erro ao processar requisição POST para /api/resposta: ~w~n', [Error]),
            reply_json(_{error: 'Erro interno do servidor'}, [status(500)])
        )
    ).

% Incrementar pontuação e valor acumulado
incrementar_pontuacao :-
    pontuacao(P),
    NovoP is P + 1,
    retract(pontuacao(P)),
    assertz(pontuacao(NovoP)),
    valor_acumulado(V),
    NovoV is V + 65000,
    retract(valor_acumulado(V)),
    assertz(valor_acumulado(NovoV)).

% Finalizar o jogo
finalizar_jogo :-
    pontuacao(P),
    valor_acumulado(V),
    reply_json(_{status: 'Fim de jogo', pontuacao: P, valor_acumulado: V}).

% Desistir do jogo
desistir(_Request) :-
    valor_acumulado(V),
    ValorDesistencia is V * 0.55,
    reply_json(_{status: 'Desistiu', valor: ValorDesistencia}).

% Manter servidor ativo
server_loop :-
    repeat,
    sleep(3600),
    fail.

% Iniciar servidor na porta 8080
:- initialization(server(8080)),
   initialization(server_loop).

:- http_handler(root(api/ajuda), fornecer_ajuda, []).
fornecer_ajuda(_Request) :-
    reply_json(_{mensagem: 'Este é o Show do Milhão! Responda as perguntas corretamente e ganhe pontos. Clique na alternativa correta para responder.'}).
