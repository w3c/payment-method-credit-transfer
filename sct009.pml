@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Merchant" as Beneficiary
Actor "Alice" as Originator
participant "Bank A" as APSP

== Bill presentment mixed with credit transfer intiation (web mode) ==

Beneficiary -[#blue]-> Originator : CreditorPaymentActivationRequest


Originator -> APSP : CustomerCreditTransferInitiation
APSP -[#green]-> APSP : controls ans internally \n submitting credit transfer
APSP -> Originator : CustomerPaymentStatusReport

Originator -[#blue]-> Beneficiary : CreditorPaymentactivationRequestStatusReport

note left Originator
the "RquestStatusReport" could provide the consent of Alice
AND the result of the initiation from the Bank of Alice
end note

== Bank of Alice credits Bank of Merchant (batch mode )==

APSP -[#green]-> BPSP : FIToFICustormerCreditTransfer

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
