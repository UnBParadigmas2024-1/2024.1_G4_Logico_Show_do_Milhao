:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

:- dynamic jogador/1.
:- dynamic pontuacao/1.
:- dynamic pergunta/4.

% Carregar perguntas e respostas
carregar_perguntas :-
    assertz(pergunta(1, 'Qual é a capital do Brasil?', ['a) Rio de Janeiro', 'b) Brasília', 'c) São Paulo', 'd) Salvador'], 'b')),
    assertz(pergunta(2, 'Qual é o maior planeta do Sistema Solar?', ['a) Terra', 'b) Marte', 'c) Júpiter', 'd) Saturno'], 'c')),
    assertz(pergunta(3, 'Quem pintou a Mona Lisa?', ['a) Vincent van Gogh', 'b) Leonardo da Vinci', 'c) Pablo Picasso', 'd) Michelangelo'], 'b')),
    assertz(pergunta(4, 'Em que ano o homem pisou na Lua pela primeira vez?', ['a) 1965', 'b) 1967', 'c) 1969', 'd) 1971'], 'c')),
    assertz(pergunta(5, 'Qual é o maior oceano do mundo?', ['a) Oceano Atlântico', 'b) Oceano Índico', 'c) Oceano Pacífico', 'd) Oceano Ártico'], 'c')).

% Servidor Web
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- http_handler(root(.), http_reply_from_files('web', []), [prefix]).
:- http_handler(root(api/iniciar), iniciar_jogo, []).
:- http_handler(root(api/pergunta), enviar_pergunta, []).
:- http_handler(root(api/resposta), verificar_resposta, []).

% Iniciar o jogo
iniciar_jogo(_Request) :-
    carregar_perguntas,
    retractall(jogador(_)),
    retractall(pontuacao(_)),
    assertz(pontuacao(0)),
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

% Incrementar pontuação
incrementar_pontuacao :-
    pontuacao(P),
    NovoP is P + 1,
    retract(pontuacao(P)),
    assertz(pontuacao(NovoP)).

% Finalizar o jogo
finalizar_jogo :-
    pontuacao(P),
    reply_json(_{status: 'Fim de jogo', pontuacao: P}).

% Manter servidor ativo
server_loop :-
    repeat,
    sleep(3600),
    fail.

% Iniciar servidor na porta 8080
:- initialization(server(8080)),
   initialization(server_loop).
