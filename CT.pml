@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "Payee Bank [Creditor Agent]" as MPSP
Participant "Payee Website" as Payee
participant "Payer's (Shopper's) Browser" as UA
Actor "Payer" as Payer
participant "Payment Mediator" as UAM
participant "Payment App" as PSPUI


note over Payee, PSPUI: HTTPS

title Basic Credit Transfer Flow

== Negotiation of Payment Terms & Selection of Payment Instrument ==

Payer<-[#green]>Payee: Establish Payment Obligation (including delivery)
Payee->UA: Payment & delivery details

UA->UAM: PaymentRequest (Items, Amounts, Shipping Options, <b><color:red>IBAN, BIC, Reference</color></b> )
note right #aqua: PaymentRequest.Show() 
opt
	Payer<-[#green]>UAM: Select Shipping Options	
	UAM->UA: Shipping Info
	note right #aqua: shippingoptionchange or shippingaddresschange events

	UA->UAM: Revised PaymentRequest
end

Payer<-[#green]>UAM: Select <b><color:red>Credit Transfer</color></b> Payment App/Instrument

UAM<-[#green]>PSPUI: Invoke Payment App

UAM->PSPUI: PaymentRequest (- Options)

note over UAM: IBAN details displayed on screen with details about how to make payment, potential printed details

Payer<-[#green]>PSPUI: <b><color:red>Commit to Pay</color></b>

PSPUI->UAM: Payment App Response


UAM->UA: Payment App Response

Note Right #aqua: Show() Promise Resolves 

== Notification ==

UA->UAM: Payment <b><color:red>Pending</color></b> Status

note over UAM #aqua: response.complete(status)

UAM->UA: UI Removed

note over UAM #aqua: complete promise resolves

UA->UA: Navigate to Result Page

...

== Payment Processing ==

note over Payer: Payer credits merchant bank account by some means

== Notification ==	

MPSP-[#black]>Payee: Payment Notification

...

== Delivery of Product ==

Payee->Payer: Meet any service obligation established in step 1

@enduml