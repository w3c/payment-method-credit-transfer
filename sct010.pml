@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Merchant" as Beneficiary
Actor "Alice" as Originator
participant "Bank A" as APSP

== Push credit transfer intiation (web mode) ==

Beneficiary -[#blue]-> Originator : CreditorPaymentActivationRequest


Originator -> APSP : CustomerCreditTransferInitiation
APSP -[#green]-> APSP : controls and providing token \n in order to submitt the payment  
APSP -> Originator : CustomerPaymentStatusReport

Originator -[#blue]-> Beneficiary : CreditorPaymentactivationRequestStatusReport

note left Originator
the "RequestStatusReport"  provide the consent of Alice
AND the acceptation from the Bank of Alice (token)
BUT the credit transfer is still pending  wiating for the token
end note

Beneficiary -[#green]-> APSP : providing toke to trigger the fund transfer
APSP -[#green]-> Beneficiary : status report of the credit transfer initiation

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
