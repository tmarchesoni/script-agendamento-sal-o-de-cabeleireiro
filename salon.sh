#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # Buscar e listar serviços cadastrados
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
  
  echo "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  # Ler ID do serviço escolhido
  read SERVICE_ID_SELECTED

  # Verificar se o serviço existe
  HAVE_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")

  if [[ -z $HAVE_SERVICE ]]
  then
    # Se o serviço não existir, mostra o menu novamente
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    # Solicitar telefone
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    # Buscar nome do cliente pelo telefone
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

    # Se não for cliente cadastrado, pedir o nome e inserir na tabela
    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME

      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
    fi

    # Buscar o customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")

    # Solicitar o horário
    echo -e "\nWhat time would you like your $HAVE_SERVICE, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # Inserir o agendamento
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")

    # Mensagem final de confirmação
    echo -e "\nI have put you down for a $HAVE_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU