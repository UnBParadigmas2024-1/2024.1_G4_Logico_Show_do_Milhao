:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(random)).

:- dynamic jogador/1.
:- dynamic pontuacao/1.
:- dynamic valor_acumulado/1.
:- dynamic pergunta/5.
:- dynamic perguntas_em_ordem/1.

% Carregar perguntas e respostas
carregar_perguntas :-
    Perguntas = [
        pergunta(1, 'Qual é a capital do Brasil?', ['a) Rio de Janeiro', 'b) Brasília', 'c) São Paulo', 'd) Salvador'], 'b', 'A capital foi fundada em 1960.'),
        pergunta(2, 'Qual é o maior planeta do Sistema Solar?', ['a) Terra', 'b) Marte', 'c) Júpiter', 'd) Saturno'], 'c', 'Esse planeta é conhecido como um gigante gasoso.'),
        pergunta(3, 'Quem pintou a Mona Lisa?', ['a) Vincent van Gogh', 'b) Leonardo da Vinci', 'c) Pablo Picasso', 'd) Michelangelo'], 'b', 'O pintor é italiano e viveu durante o Renascimento.'),
        pergunta(4, 'Em que ano o homem pisou na Lua pela primeira vez?', ['a) 1965', 'b) 1967', 'c) 1969', 'd) 1971'], 'c', 'O evento ocorreu durante a missão Apollo 11.'),
        pergunta(5, 'Qual é o maior oceano do mundo?', ['a) Oceano Atlântico', 'b) Oceano Índico', 'c) Oceano Pacífico', 'd) Oceano Ártico'], 'c', 'Este oceano cobre mais de 63 milhões de milhas quadradas.'),
        pergunta(6, 'Qual é o maior mamífero terrestre?', ['a) Elefante', 'b) Girafa', 'c) Hipopotamo', 'd) Rinoceronte'], 'a', 'Este animal é conhecido por sua tromba longa.'),
        pergunta(7, 'Qual é a capital da França?', ['a) Paris', 'b) Lyon', 'c) Marseille', 'd) Toulouse'], 'a', 'A cidade é conhecida como "A Cidade da Luz".'),
        pergunta(8, 'Quem escreveu "Dom Casmurro"?', ['a) Machado de Assis', 'b) José de Alencar', 'c) Jorge Amado', 'd) Lima Barreto'], 'a', 'O autor é um dos fundadores da Academia Brasileira de Letras.'),
        pergunta(9, 'Qual é o elemento químico representado pelo símbolo Au?', ['a) Ouro', 'b) Prata', 'c) Alumínio', 'd) Cobre'], 'a', 'Este metal precioso é amarelo e altamente valorizado.'),
        pergunta(10, 'Qual planeta é conhecido como o "planeta vermelho"?', ['a) Marte', 'b) Vênus', 'c) Júpiter', 'd) Saturno'], 'a', 'Este planeta tem uma coloração avermelhada devido ao óxido de ferro em sua superfície.'),
        pergunta(11, 'Qual é o idioma oficial do Brasil?', ['a) Espanhol', 'b) Português', 'c) Inglês', 'd) Francês'], 'b', 'O idioma é de origem latina e é falado por mais de 200 milhões de pessoas no país.'),
        pergunta(12, 'Em que ano foi fundada a cidade de São Paulo?', ['a) 1554', 'b) 1600', 'c) 1700', 'd) 1800'], 'a', 'A cidade foi fundada por padres jesuítas.'),
        pergunta(13, 'Quem foi o primeiro presidente do Brasil?', ['a) Marechal Deodoro da Fonseca', 'b) Getúlio Vargas', 'c) Juscelino Kubitschek', 'd) Pedro II'], 'a', 'O presidente era um marechal do Exército Brasileiro.'),
        pergunta(14, 'Qual é o menor estado brasileiro em termos de área?', ['a) São Paulo', 'b) Rio de Janeiro', 'c) Sergipe', 'd) Alagoas'], 'c', 'Este estado está localizado na região Nordeste do Brasil.'),
        pergunta(15, 'Qual é o maior rio do mundo em volume de água?', ['a) Nilo', 'b) Amazonas', 'c) Yangtze', 'd) Mississippi'], 'b', 'Este rio passa por vários países da América do Sul.'),
        pergunta(16, 'Qual é a maior montanha do mundo?', ['a) K2', 'b) Kangchenjunga', 'c) Lhotse', 'd) Everest'], 'd', 'A montanha está localizada no Himalaia.'),
        pergunta(17, 'Quem escreveu "Hamlet"?', ['a) William Shakespeare', 'b) Charles Dickens', 'c) Mark Twain', 'd) Jane Austen'], 'a', 'O autor é considerado um dos maiores dramaturgos de todos os tempos.'),
        pergunta(18, 'Qual é a fórmula química da água?', ['a) H2O', 'b) CO2', 'c) O2', 'd) H2SO4'], 'a', 'Esta substância é essencial para a vida.'),
        pergunta(19, 'Quem desenvolveu a teoria da relatividade?', ['a) Isaac Newton', 'b) Albert Einstein', 'c) Galileo Galilei', 'd) Niels Bohr'], 'b', 'O cientista é famoso pela equação E=mc².'),
        pergunta(20, 'Qual é a moeda oficial do Japão?', ['a) Yuan', 'b) Won', 'c) Yen', 'd) Ringgit'], 'c', 'A moeda é abreviada como JPY.'),
        pergunta(21, 'Em que ano começou a Primeira Guerra Mundial?', ['a) 1912', 'b) 1914', 'c) 1916', 'd) 1918'], 'b', 'A guerra iniciou após o assassinato do arquiduque Francisco Ferdinando.'),
        pergunta(22, 'Qual é o menor planeta do Sistema Solar?', ['a) Mercúrio', 'b) Vênus', 'c) Terra', 'd) Marte'], 'a', 'Este planeta está mais próximo do Sol.'),
        pergunta(23, 'Quem foi o primeiro homem a orbitar a Terra?', ['a) Neil Armstrong', 'b) Buzz Aldrin', 'c) Yuri Gagarin', 'd) John Glenn'], 'c', 'O astronauta era soviético.'),
        pergunta(24, 'Qual é a língua mais falada no mundo?', ['a) Espanhol', 'b) Inglês', 'c) Chinês', 'd) Hindi'], 'c', 'Esta língua tem mais de um bilhão de falantes.'),
        pergunta(25, 'Qual é o maior deserto do mundo?', ['a) Deserto do Saara', 'b) Deserto de Gobi', 'c) Deserto do Atacama', 'd) Antártica'], 'd', 'Embora frio, este deserto cobre uma grande área de gelo.'),
        pergunta(26, 'Quem descobriu a penicilina?', ['a) Louis Pasteur', 'b) Alexander Fleming', 'c) Robert Koch', 'd) Joseph Lister'], 'b', 'Esta descoberta revolucionou a medicina.'),
        pergunta(27, 'Qual é a capital da Austrália?', ['a) Sydney', 'b) Melbourne', 'c) Canberra', 'd) Brisbane'], 'c', 'A cidade foi escolhida como um compromisso entre Sydney e Melbourne.'),
        pergunta(28, 'Qual é o gás mais abundante na atmosfera terrestre?', ['a) Oxigênio', 'b) Hidrogênio', 'c) Nitrogênio', 'd) Dióxido de carbono'], 'c', 'Este gás compõe cerca de 78% da atmosfera.'),
        pergunta(29, 'Qual é a maior ilha do mundo?', ['a) Groenlândia', 'b) Nova Guiné', 'c) Bornéu', 'd) Madagascar'], 'a', 'Esta ilha é uma região autônoma do Reino da Dinamarca.'),
        pergunta(30, 'Quem pintou o teto da Capela Sistina?', ['a) Leonardo da Vinci', 'b) Michelangelo', 'c) Raphael', 'd) Donatello'], 'b', 'O artista era também um escultor renomado.'),
        pergunta(31, 'Qual é a substância mais dura encontrada na natureza?', ['a) Quartzo', 'b) Corindo', 'c) Diamante', 'd) Topázio'], 'c', 'Esta substância é composta de carbono em estrutura cristalina.'),
        pergunta(32, 'Qual foi a primeira civilização a desenvolver a escrita?', ['a) Egípcia', 'b) Suméria', 'c) Grega', 'd) Romana'], 'b', 'Esta civilização utilizava a escrita cuneiforme.'),
        pergunta(33, 'Qual é a maior estrela do nosso sistema solar?', ['a) Sirius', 'b) Alpha Centauri', 'c) Betelgeuse', 'd) Sol'], 'd', 'Esta estrela é essencial para a vida na Terra.'),
        pergunta(34, 'Em que continente fica o Egito?', ['a) África', 'b) Ásia', 'c) Europa', 'd) América do Sul'], 'a', 'Este país é famoso por suas pirâmides antigas.'),
        pergunta(35, 'Qual é o animal mais rápido do mundo?', ['a) Guepardo', 'b) Falcão peregrino', 'c) Leopardo', 'd) Cavalo'], 'a', 'Este animal pode atingir velocidades superiores a 100 km/h.'),
        pergunta(36, 'Segundo o cantor Crazy Frog em sua canção, o que ele quer?',['a) ABLINGLINBLINBLONBLONBLINBLINBLAI', 'b) BRINGLINGLONGLONGLONGLENGANGLENGLEN', 'c) BRANGANGANGENGENGANGLINGLIN', 'd) BINBIN'],'d', 'Talvez ele queira algo simples')
    ],
    random_permutation(Perguntas, PerguntasEmbaralhadas),
    retractall(perguntas_em_ordem(_)),
    assertz(perguntas_em_ordem(PerguntasEmbaralhadas)).

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
