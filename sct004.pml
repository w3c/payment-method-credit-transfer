@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

participant "BANK B" as BPSP
Actor "Bob" as Beneficiary
Actor "Alice" as Originator
participant "Bank A" as APSP

== Alice initiates a Credit Transfer to Bob ==

Originator -> APSP : CustomerCreditTransferInitiation
APSP -> Originator : CustomerPaymentStatusReport

== Bank of Alice credits Bank of Bob ==

APSP -> BPSP : FIToFICustormerCreditTransfer

== Notification of Bob ==

BPSP -> Beneficiary : BankToCustomerDebitCreditNotification
@enduml
