@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Merchant" as Beneficiary
Actor "Alice" as Originator
participant "Bank A" as APSP

== Bill presentment ==

Beneficiary -[#blue]-> Originator : CreditorPaymentActivationRequest
Originator -[#blue]-> Beneficiary : CreditorPaymentactivationRequestStatusReport

note left APSP
the "RequestStatusReport" gives information on the consent of Alice
but gives no indication on the Credit Transfer itself
end note

== Alice initiates a Credit Transfer to Bob ==

Originator -> APSP : CustomerCreditTransferInitiation
APSP -> Originator : CustomerPaymentStatusReport

note left Originator
the "PaymentStatusReport" is not sent to the merchant
end note

== Bank of Alice credits Bank of Bob ==

APSP -> BPSP : FIToFICustormerCreditTransfer

note left APSP
As a lot of Credit Transfer interbank mechanism are not real time
there is no way to use this flow to warn the merchant of the availability of funds
end note

== Notification of Bob ==

BPSP -> Beneficiary : BankToCustomerDebitCreditNotification

note right BPSP
This information come often late (day+1 or worse) and 
cannot be used to manage the flow of acceptation of purchase
or to automatically link to delivery process
end note
@enduml
