% perguntas.pl

:- dynamic pergunta/5.

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
        pergunta(36, 'Segundo o cantor Crazy Frog em sua canção, o que ele quer?',['a) ABLINGLINBLINBLONB', 'b) BRINGLINGLONGLONGLONGLENG', 'c) BRANGANGANGENGEN', 'd) BINBIN'],'d', 'Talvez ele queira algo simples'),
        pergunta(37, 'Em que ano ocorreu a queda do Muro de Berlim?', ['a) 1985', 'b) 1987', 'c) 1989', 'd)1991'], 'c', 'Simbolizando o fim da Guerra Fria'),
        pergunta(38, 'Qual é o livro mais vendido de todos os tempos?', ['a) O Senhor dos Anéis', 'b) O Pequeno Príncipe', 'c) Bíblia', 'd) Harry Potter e a Pedra Filosofal'], 'c', 'Amplamente distribuído e traduzido em várias línguas ao redor do mundo'),
        pergunta(39, 'Qual é o oceano mais profundo do mundo?', ['a)Atlântico', 'b) Índico', 'c) Pacífico', 'd) Ártico'], 'c', 'Com profundidades que atingem o ponto mais baixo da Terra'),
        pergunta(40, 'Quem inventou a lâmpada elétrica?', ['a) Nikola Tesla', 'b) Thomas Edison', 'c) Alexander Graham Bell', 'd) James Watt'], 'b', 'É conhecido por suas inovações em eletricidade e iluminação'),
        pergunta(41, 'Qual atividade esportiva mais famosa no japão?', ['a) Basebol', 'b) Judô', 'c) Karatê', 'd) Sumô '], 'a', 'Apesar do Sumô ser considerado o esporte nacional do japão o basebol é o mais popular, sendo considerado o esporte não-oficial nacional'),
        pergunta(42, 'Em que ano a independência do Brasil ocorreu?', ['a) 1889', 'b) 1822', 'c) 1823 ', 'd) 1888'], 'b', 'O que será que maria leopodildina penso quando assinou a independência do Brasil e dom pedro disse que ficava'),
        pergunta(43, 'Qual é o recorde mundial para mais tempo vivendo embaixo de água?', ['a) 60 dias', 'b) 20 minutos', 'c) 87 dias', 'd) 74 dias'], 'd', 'Sim, o tempo de vivendo baixo de água foi feito pelo americano Joseph Dituri')
    ],
    random_permutation(Perguntas, PerguntasEmbaralhadas),
    retractall(perguntas_em_ordem(_)),
    assertz(perguntas_em_ordem(PerguntasEmbaralhadas)).
