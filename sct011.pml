@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Merchant" as Beneficiary
participant "PISP" as PISP
Actor "Alice" as Originator
participant "Bank A" as APSP

== PISP credit transfer intiation (web mode) ==

Beneficiary -[#blue]> Originator : CreditorPaymentActivationRequest


Originator -[#blue]> PISP : account & bank information
PISP -[#blue]-> APSP : CustomerCreditTransferInitiation using the API of Bank A
APSP -[#green]-> APSP : authentication of PISP
APSP  -[#orange]-> Originator : authentication challenge linked with amount & merchant
Originator -[#orange]-> APSP :consent for the credit Transfer
APSP -[#green]-> APSP : submitting credit transfer \n to internal systems
APSP -[#blue]-> PISP: CustomerPaymentStatusReport

PISP -[#blue]> Beneficiary : CreditorPaymentactivationRequestStatusReport


== Bank of Alice credits Bank of Merchant (batch mode )==

APSP -[#green]> BPSP : FIToFICustormerCreditTransfer

note left APSP
As a lot of Credit Transfer interbank mechanism are not real time
there is no way to use this flow to warn the merchant of the availability of funds
end note

== Bank Notification of Merchant ==

BPSP -[#green]-> Beneficiary : BankToCustomerDebitCreditNotification

note right BPSP
depending of Credit Transfer Scheme, this information is often
not interesting at operationnal level for the merchant
end note
@enduml
