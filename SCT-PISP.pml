@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "Payment Initiation Service Provider" as MPSP
Participant "Payee" as Payee
Actor "Payer" as Payer
participant "Payment App" as PSPUI
participant "Payer's Bank" as CPSP

note over Payee, PSPUI: HTTPS

title PISP Initiated SEPA Credit Transfer

== Negotiation of Payment Terms & Selection of Payment Instrument ==

Payee<->Payer: Offer Negotiation

== Payment Initiation ==

Payee->PSPUI: PaymentRequest with CreditTransferRequest

PSPUI->CPSP: Submit Payment Initiation Request

note over PSPUI
API to receive credit transfer initiation including all data set from CreditTransferRequest
(e.g. PSD2 / OpenBanking API if Payment App from 3rd Party)
end note

PSPUI->CPSP: Authenticate

CPSP->PSPUI: Return authorizationToken

note over CPSP
initiation is pending waiting for token to be received by regulated PISP
end note

PSPUI->Payee: CreditTransferResponse with authorizationToken

Payee -> MPSP : CreditTransferResponse with authorizationToken
MPSP -> CPSP : Submit Payment Initiation  using authorizationToken
...
== Payment Processing ==


CPSP->MPSP: Transfer Funds
note over PSPUI
if payeePaymentIdentificationUserReadable  and payeePaymentIdentificationMachineReadable
available in CreditTransferRequest then payeePaymentIdentificationMachineReadable should
be privilegied into the SEPA Credit Transfer
end note

== Notification ==

MPSP->Payee: Payment Completetion Status

== Delivery of Product ==

Payee->Payer: Meet any service obligation established in Step 1

== Bank legacy Notification  == 
CPSP->Payer: Statement or Credit transfer advice
 note over PSPUI
 both  payeePaymentIdentificationUserReadable  and payeePaymentIdentificationMachineReadable
 could be provided in CAMT-053 and CAMT-054 formats
 end note


@enduml