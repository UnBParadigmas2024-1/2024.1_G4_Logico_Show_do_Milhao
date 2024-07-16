% arquivo principal

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(random)).
:- consult('perguntas.pl').  % Adicione esta linha para carregar o arquivo de perguntas

:- dynamic jogador/1.
:- dynamic pontuacao/1.
:- dynamic valor_acumulado/1.
:- dynamic perguntas_em_ordem/1.

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
            atom_string(AtomNumero, Dados.numero), % Converte para átomo
            atom_string(AtomResposta, Dados.resposta), % Converte para átomo
            atom_number(AtomNumero, Numero), % Converte átomo para número
            perguntas_em_ordem(PerguntasEmbaralhadas),
            nth1(Numero, PerguntasEmbaralhadas, pergunta(_, _, _, RespostaCorreta, _)),
            (AtomResposta = RespostaCorreta ->
                incrementar_pontuacao,
                valor_acumulado(ValorAcumulado),
                reply_json(_{status: 'Correto', valor_acumulado: ValorAcumulado});
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
    reply_json(_{status: 'Desistiu', valor: V}).

% Fornecer dica
fornecer_dica(Request) :-
    catch(
        (   http_read_json_dict(Request, Dados),
            atom_string(AtomNumero, Dados.numero), % Converte para átomo
            atom_number(AtomNumero, Numero), % Converte átomo para número
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

:- http_handler(root(api/ajuda), fornecer_ajuda, []).
fornecer_ajuda(_Request) :-
    reply_json(_{mensagem: 'Este é o Show do Milhão! Responda as perguntas corretamente e ganhe pontos. Clique na alternativa correta para responder.'}).

