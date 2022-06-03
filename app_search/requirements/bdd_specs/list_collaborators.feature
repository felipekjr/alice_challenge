Feature: Listar colaboradores cadastrados
Como um cliente
Quero poder visualizar a lista de colaboradores cadastrados na rede da Alice.

Scenario: Sucesso
Dado que o cliente está utilizando o aplicativo
Quando acessar a página de busca
Então o sistema deve exibir uma lista com os colaboradores cadastrados

Scenario: Falha
Dado que o cliente está utilizando o aplicativo
Quando acessar a página de busca
Então o sistema deve exibir uma lista com os colaboradores cadastrados
E caso haja falha
Então o sistema deve exibir uma mensagem de erro