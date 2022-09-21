#language: pt

Funcionalidade: login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login
    Cenario: Login do usuário

        Dado que acesso a página principal
        Quando submeto minhas credenciais com "fernanda@log.com" e "teste123"
        Então sou redirecionado para o Dashboard

    Esquema do Cenario: Tentar logar
        Dado que acesso a página principal
        Quando submeto minhas credenciais com "<email_input>" e "<senha_input>"
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | email_input          | senha_input | mensagem_output                  |
            | fernanda@teste12.com | teste123    | Usuário e/ou senha inválidos.    |
            | fernanda@teste1.com  | teste123    | Usuário e/ou senha inválidos.    |
            | fernanda*teste.com   | teste123    | Oops. Informe um email válido!   |
            |                      | teste123    | Oops. Informe um email válido!   |
            | fernanda@login.com   |             | Oops. Informe sua senha secreta! |

