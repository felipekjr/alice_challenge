Feature: Buscar colaboradores
Como um cliente
Quero poder buscar um colaborador na lista

Scenario: Sucesso
Dado que o cliente está na página de busca
Quando começar a digitar no campo de texto
Então o sistema deve filtrar a lista pelo início do nome do colaborador, 
considerando letras maíusculas e mínusculas