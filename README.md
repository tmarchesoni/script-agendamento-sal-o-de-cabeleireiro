# My Salon

Este projeto é um scheduler de agendamentos de salão implementado em Bash e PostgreSQL. Ele oferece um menu interativo para:

- listar os serviços disponíveis;
- cadastrar clientes quando o telefone ainda não existe;
- registrar um novo agendamento;
- confirmar o serviço, horário e cliente escolhido.

## Estrutura do projeto

- `salon.sh` — script principal em Bash que executa o menu interativo.
- `salon.sql` — esquema do banco de dados PostgreSQL com as tabelas `services`, `customers` e `appointments`.
- `examples.txt` — exemplos de execução bem-sucedida do script.

## Como funciona

O script `salon.sh` usa o comando `psql` para consultar e inserir dados no banco `salon`.

Fluxo principal:

1. O usuário abre o menu inicial.
2. O script exibe os serviços cadastrados.
3. O usuário escolhe um serviço.
4. O sistema solicita o telefone do cliente.
5. Se o cliente não existir, o script pede o nome e salva o registro.
6. O usuário informa o horário desejado.
7. O agendamento é gravado na tabela `appointments`.
8. O script exibe a confirmação final.

## Banco de dados

O banco usa as seguintes tabelas:

- `services`: armazena os serviços disponíveis
- `customers`: armazena telefone e nome dos clientes
- `appointments`: armazena os agendamentos, incluindo cliente, serviço e horário

Também há chaves primárias e chaves estrangeiras para manter a integridade dos dados.

## Como executar

1. Certifique-se de que o PostgreSQL esteja instalado e acessível.
2. Crie ou restaure o banco a partir do arquivo `salon.sql`.
3. Execute o script:

```bash
bash salon.sh
```

## Exemplo de uso

Ao iniciar o script, a interface mostra algo como:

```text
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?

1) cut
2) color
3) perm
```

A partir daí, o usuário escolhe um serviço, informa o telefone, nome quando necessário e o horário do agendamento.

## Observação

Este projeto foi desenvolvido como exercício de integração entre Bash e PostgreSQL, focando em:

- interação via terminal;
- manipulação de dados em banco relacional;
- uso de consultas SQL dentro de scripts shell.
