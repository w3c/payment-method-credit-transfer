@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Bob" as Beneficiary
Actor "Alice" as Originator
participant "Bank A" as APSP

== Prerequisites ==
Beneficiary -[#blue]-> Originator 
note left Beneficiary
Bob should find a way to give
his account number and
Bank coordinate to Alice 
before the initiation
end note

== Alice initiates a Credit Transfer to Bob ==

Originator -> APSP : CustomerCreditTransferInitiation
APSP -> Originator : CustomerPaymentStatusReport
note left APSP  
No information of this status
is aumomatically available 
for the Beneficiary
end note

== Bank of Alice credits Bank of Bob ==

APSP -> BPSP : FIToFICustormerCreditTransfer

== Notification of Bob ==

BPSP -> Beneficiary : BankToCustomerDebitCreditNotification
@enduml
