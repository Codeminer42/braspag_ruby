# Braspag

Provê uma forma mais simples de integrar o Ruby com o gateway de pagamento Braspag através do protocolo SOAP.

## Instalação

Adicione essa linha ao seu Gemfile:

```bash
gem 'braspag'
```

E execute:

```bash
$ bundle
```

Ou instale manualmente:

```bash
$ gem install braspag
```

## Como funciona

A gem Braspag atualmente suporta as seguintes tipos de transações:

### Autorização (método AuthorizeTransaction)

O método AuthorizeTransaction é utilizado para autorizar transações de cartão de crédito, boleto e etc. No caso do cartão, a autorização é a primeira perna da transação. Apenas verifica se o cartão é válido, se tem limite e retém o limite até segunda ordem - mais informações vide documentação.

Exemplo de autorização:

```ruby
Braspag::Transaction.authorize(
  "OrderId" => @order.id,          # Identificador do pedido/pagamento no seu sistema
  "CustomerIdentity" => @user.id,  # Identificador do cliente no seu sistema
  "CustomerName" => @user.name,    # Nome do cliente
  "CustomerEmail" => @user.email,  # E-mail do cliente
  "CreditCardToken" => @user.credit_card_token,  # Token do cartão de crédito do cliente fornecido pelo Braspag
  "Street" => @user.address.street,              # Endereço
  "ZipCode" => @user.zip_code,                   # CEP
  "PaymentMethod" => 500,      # Código de meio de pagamento (500 - Cielo Visa) / vide documentação
  "NumberOfPayments" => 1,     # Número de vezes que a transação foi parcelada / vide documentação
  "PaymentPlan" => 0,          # Código de plano de pagamento (0 - à vista) / vide documentação
  "TransactionType" => 1,      # Tipo de transação (1 - pré-autorização) / vide documentação
  "Currency" => "BRL",         # Moeda
  "City" => "São Paulo",       # Cidade
  "State" => "SP",             # Estado
  "Country" => "BRA",          # País
  "Amount" => @order.value     # Valor
)
```

### Captura

### Cancelamento

### Refund (Estorno)
TODO - não implementado

### ChargeBack
TODO - não implementado

## Contribuindo

1. Faça fork do projeto
2. Crie a sua feature branch (`git checkout -b my-new-feature`)
3. Faça commit das suas mudanças (`git commit -am 'Add some feature'`)
4. Envie suas mudanças (`git push origin my-new-feature`)
5. Crie um novo pull request
