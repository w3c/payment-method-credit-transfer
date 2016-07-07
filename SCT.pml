@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "Payee's Bank" as MPSP
Participant "Payee" as Payee
Actor "Payer" as Payer
participant "Payment App" as PSPUI
participant "Payer's Bank" as CPSP

note over Payee, PSPUI: HTTPS

title Payer Initiated SEPA Credit Transfer

== Negotiation of Payment Terms & Selection of Payment Instrument ==

Payee<->Payer: Offer Negotiation

== Payment Initiation ==

Payee->PSPUI: PaymentRequest with PullSCTRequest

PSPUI->CPSP: Authenticate
PSPUI->CPSP: Submit Payment Initiation Request

note over PSPUI: PAIN.001.003 request or equivalent (e.g. PSD2 / OpenBanking API if Payment App from 3rd Party)
CPSP->PSPUI: Return Processing Date

PSPUI->Payee: PullSCTResponse

...

== Payment Processing ==

CPSP->MPSP: Transfer Funds
	
== Notification ==

MPSP->Payee: Payment Completetion Status

== Delivery of Product ==

Payee->Payer: Meet any service obligation established in Step 1

@enduml