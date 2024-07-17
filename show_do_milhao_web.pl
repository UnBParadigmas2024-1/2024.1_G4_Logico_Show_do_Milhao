:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(random)).
:- consult('perguntas.pl').

:- dynamic jogador/1.
:- dynamic pontuacao/1.
:- dynamic valor_acumulado/1.
:- dynamic perguntas_em_ordem/1.
:- dynamic pulou/1.

% Servidor Web
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- http_handler(root(.), http_reply_from_files('web', []), [prefix]).
:- http_handler(root(api/iniciar), iniciar_jogo, []).
:- http_handler(root(api/pergunta), enviar_pergunta, []).
:- http_handler(root(api/resposta), verificar_resposta, []).
:- http_handler(root(api/ajuda), fornecer_ajuda, []).
:- http_handler(root(api/dica), fornecer_dica, []).
:- http_handler(root(api/desistir), desistir, []).
:- http_handler(root(api/pular), pular_pergunta, []).
:- http_handler(root(api/audio_url), musica_milhao, []).

% Iniciar o jogo
iniciar_jogo(_Request) :-
    carregar_perguntas,
    retractall(jogador(_)),
    retractall(pontuacao(_)),
    retractall(valor_acumulado(_)),
    retractall(pulou(_)),
    assertz(pontuacao(0)),
    assertz(valor_acumulado(0)),
    assertz(pulou(false)),
    reply_json(_{status: 'Jogo iniciado'}).

% Enviar pergunta
enviar_pergunta(_Request) :-
    pontuacao(P),
    perguntas_em_ordem(PerguntasEmbaralhadas),
    length(PerguntasEmbaralhadas, NumPerguntas),
    (P < NumPerguntas ->
        nth0(P, PerguntasEmbaralhadas, pergunta(_, Pergunta, Alternativas, _, Dica)),
        ProximaPergunta is P + 1,
        (ProximaPergunta mod 5 =:= 0 ->
            reply_json(_{numero: ProximaPergunta, pergunta: Pergunta, alternativas: Alternativas, dica: Dica, especial: true});
            reply_json(_{numero: ProximaPergunta, pergunta: Pergunta, alternativas: Alternativas, dica: Dica}));
        finalizar_jogo).

% Verificar resposta
verificar_resposta(Request) :-
    catch(
        (   http_read_json_dict(Request, Dados),
            Numero is Dados.numero, % Diretamente convertendo para número
            atom_string(Dados.resposta, Resposta),
            format(user_error, 'Recebido: numero=~w, resposta=~w~n', [Numero, Resposta]),
            perguntas_em_ordem(PerguntasEmbaralhadas),
            nth1(Numero, PerguntasEmbaralhadas, pergunta(_, _, _, RespostaCorreta, _)),
            atom_string(RespostaCorreta, RespostaCorretaString),
            atom_string(Resposta, RespostaString),
            format(user_error, 'Resposta correta: ~w~n', [RespostaCorretaString]),
            (RespostaString == RespostaCorretaString ->
                incrementar_pontuacao,
                valor_acumulado(ValorAcumulado),
                reply_json(_{status: 'Correto', valor_acumulado: ValorAcumulado});
                reply_json(_{status: 'Errado', resposta_correta: RespostaCorretaString}))
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

% Enviar próxima pergunta
enviar_proxima_pergunta :-
    pontuacao(P),
    perguntas_em_ordem(PerguntasEmbaralhadas),
    length(PerguntasEmbaralhadas, NumPerguntas),
    (P < NumPerguntas ->
        nth0(P, PerguntasEmbaralhadas, pergunta(_, Pergunta, Alternativas, _, Dica)),
        ProximaPergunta is P + 1,
        (ProximaPergunta mod 5 =:= 0 ->
            reply_json(_{numero: ProximaPergunta, pergunta: Pergunta, alternativas: Alternativas, dica: Dica, especial: true});
            reply_json(_{numero: ProximaPergunta, pergunta: Pergunta, alternativas: Alternativas, dica: Dica}));
        finalizar_jogo).

% Pular pergunta
pular_pergunta(_Request) :-
    pulou(false),
    incrementar_pontuacao,
    retract(pulou(false)),
    assertz(pulou(true)),
    enviar_proxima_pergunta.

% Musica Milhao
musica_milhao(_Request) :-
    format('Content-type: text/plain~n~n'),
    format('{"audio_url": "http://localhost:8080/audio/ost.mp3"}').

% Finalizar o jogo
finalizar_jogo :-
    pontuacao(P),
    valor_acumulado(V),
    reply_json(_{status: 'Fim de jogo', pontuacao: P, valor_acumulado: V}).

% Desistir do jogo
desistir(_Request) :-
    valor_acumulado(V),
    reply_json(_{status: 'Desistiu', valor: V}).

% Fornecer dica
fornecer_dica(Request) :-
    catch(
        (   http_read_json_dict(Request, Dados),
            Numero is Dados.numero, % Diretamente convertendo para número
            perguntas_em_ordem(PerguntasEmbaralhadas),
            nth1(Numero, PerguntasEmbaralhadas, pergunta(_, _, _, _, Dica)),
            reply_json(_{dica: Dica})
        ),
        Error,
        (   format(user_error, 'Erro ao processar requisição para /api/dica: ~w~n', [Error]),
            reply_json(_{error: 'Erro interno do servidor'}, [status(500)])
        )
    ).

% Manter servidor ativo
server_loop :-
    repeat,
    sleep(3600),
    fail.

% Iniciar servidor na porta 8080
:- initialization(server(8080)),
   initialization(server_loop).

% Fornecer ajuda
fornecer_ajuda(_Request) :-
    reply_json(_{mensagem: 'Este é o Show do Milhão! Responda as perguntas corretamente e ganhe pontos. Clique na alternativa correta para responder.'}).
