/**
 * Created by rashimi on 2/28/2022.
 */

public with sharing class WebinarTriggerHandler {
    public static void handleBeforeInsert(List<Webinar__c> newList){
        setStatusBasedOnCost(newList);
        setStatusBasedOnApprovalStatus(newList);
        throwErrorIfParticipantsMoreThanSeats(newList);
        calculatePricePerParticipant(newList);
    }

    public static void handleBeforeUpdate(List<Webinar__c> newList){
        setStatusBasedOnCost(newList);
        setStatusBasedOnApprovalStatus(newList);
        throwErrorIfParticipantsMoreThanSeats(newList);
        calculatePricePerParticipant(newList);
    }

    public static void handleAfterUpdate(Map<Id,Webinar__c> oldList, Map<Id,Webinar__c> newList){
        throwErrorIfStatusChangesAndAppStatusPending(oldList,newList);
    }

    private static void setStatusBasedOnCost(List<Webinar__c> newList){
        for(Webinar__c web : newList){
            if(web.Cost__c<100){
                web.Approval_Status__c='Approved';
            }
        }
    }

    private static void setStatusBasedOnApprovalStatus(List<Webinar__c> newList){
        for(Webinar__c web : newList){
            if(web.Approval_Status__c.equals('Rejected')){
                web.Status__c='Cancelled';
            }
        }
    }

    private static void throwErrorIfParticipantsMoreThanSeats(List<Webinar__c> newList){
        for(Webinar__c web : newList){
            if(web.Number_of_Participants__c>web.Total_Number_of_Seats__c){
                web.addError('Number of participants cannot exceed the number of seats.');
            }
        }
    }

    private static void calculatePricePerParticipant(List<Webinar__c> newList){
        for(Webinar__c web : newList){
            if(web.Number_of_Participants__c!=0){
                web.Price_per_Participant__c=web.Cost__c/web.Number_of_Participants__c;
            }else{
                web.Price_per_Participant__c=0;
            }
        }
    }

    private static void throwErrorIfStatusChangesAndAppStatusPending(Map<Id,Webinar__c> oldList, Map<Id,Webinar__c> newList){
        /*for(Webinar__c web: newList.values()){
            if(!oldList.get(web.Id).Status__c.equals(web.Status__c)){
                if(!web.Status__c.equals('Cancelled') && web.Approval_Status__c.equals('Pending')){
                    web.addError('Approval status cannot be pending.');
                }
            }
        }*/
        for(Webinar__c web: newList.values()){
            Webinar__c oldRecord=oldList.get(web.Id);
            if(oldRecord.Status__c=='New' && web.Status__c!='New' && web.Status__c!='Cancelled' && web.Approval_Status__c=='Pending'){
                web.addError('Approval status cannot be pending.');
            }
        }
    }
}