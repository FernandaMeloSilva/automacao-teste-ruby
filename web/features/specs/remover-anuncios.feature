#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse Anúncios
    Para que eu possa manter meu dashboard atualizado

    Contexto: Login
        * Login com "silva@gmail.com" e "teste123"

    Cenario: Remover um anúncio
        Dado que eu tenha um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 50             |

        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu dashboard

    @temp
    Cenario: Desistir da exclusão
        Dado que eu tenha um anúncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 100       |
        Quando eu solicito a exclusão desse item
            Mas não confirmo a solicitação
        Então esse item deve permanecer no meu dashboard