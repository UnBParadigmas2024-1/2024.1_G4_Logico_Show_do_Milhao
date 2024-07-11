% show_do_milhao.pl

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

% Iniciar o jogo
iniciar :-
    write('Bem-vindo ao Show do Milhão!'), nl,
    write('Qual é o seu nome? '),
    read(Nome),
    assertz(jogador(Nome)),
    assertz(pontuacao(0)),
    carregar_perguntas,
    jogar(1).

% Jogar
jogar(Numero) :-
    pergunta(Numero, Pergunta, Alternativas, RespostaCorreta),
    format('Pergunta ~w: ~w~n', [Numero, Pergunta]),
    mostrar_alternativas(Alternativas),
    write('Qual é a sua resposta? (a, b, c ou d): '),
    read(Resposta),
    verificar_resposta(Numero, Resposta, RespostaCorreta).

% Mostrar alternativas
mostrar_alternativas([]).
mostrar_alternativas([Primeira|Resto]) :-
    write(Primeira), nl,
    mostrar_alternativas(Resto).

% Verificar resposta
verificar_resposta(Numero, Resposta, RespostaCorreta) :-
    (Resposta = RespostaCorreta ->
        write('Correto!'), nl,
        incrementar_pontuacao,
        proxima_pergunta(Numero);
        write('Errado! A resposta correta é '), write(RespostaCorreta), nl,
        finalizar).

% Incrementar pontuação
incrementar_pontuacao :-
    pontuacao(P),
    NovoP is P + 1,
    retract(pontuacao(P)),
    assertz(pontuacao(NovoP)).

% Próxima pergunta
proxima_pergunta(Numero) :-
    ProximoNumero is Numero + 1,
    (pergunta(ProximoNumero, _, _, _) ->
        jogar(ProximoNumero);
        finalizar).

% Finalizar o jogo
finalizar :-
    jogador(Nome),
    pontuacao(P),
    format('Parabéns, ~w! Você terminou o jogo com ~w pontos.~n', [Nome, P]),
    limpar_dados.

% Limpar dados
limpar_dados :-
    retractall(jogador(_)),
    retractall(pontuacao(_)),
    retractall(pergunta(_, _, _, _)).
