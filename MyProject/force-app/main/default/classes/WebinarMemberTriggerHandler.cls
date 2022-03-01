/**
 * Created by rashimi on 2/28/2022.
 */

public with sharing class WebinarMemberTriggerHandler {
        // *** Handlers ***

    public static void handleBeforeInsert(List<Webinar_Member__c> newList){
        validateCommentWhenStatusRejected(newList);
        validateRelatedFields(newList);
        validateContactFields(newList);
        duplicateRule(newList);
    }

    public static void handleBeforeUpdate(List<Webinar_Member__c> newList){
        validateCommentWhenStatusRejected(newList);
        validateRelatedFields(newList);
        validateContactFields(newList);
        duplicateRule(newList);
    }

    private static void validateCommentWhenStatusRejected(List<Webinar_Member__c> newList){
        for(Webinar_Member__c member : newList){
            if(member.Status__c.equals('Rejected') && member.Comments__c == null){
                member.addError('Comment must be filled.');
            }
        }
    }

    private static void validateRelatedFields(List<Webinar_Member__c> newList){
        for(Webinar_Member__c member : newList){
            if(member.User__c!=null && member.Contact__c!=null){
                member.addError('Webinar members have to be Contact or User.');
            }
        }
    }

    private static void validateContactFields(List<Webinar_Member__c> newList){
        for(Webinar_Member__c member : newList) {
            List<Webinar__c> relatedWebinar = [SELECT Type__c FROM Webinar__c WHERE Id = :member.Id];
            if(member.Contact__c!=null){
                for (Webinar__c relatedMember : relatedWebinar) {
                    if(relatedMember.Type__c!='External'){
                        member.addError('Contacts cannot be assigned to the webinar if the webinar type is External');
                    }
                }
            }
        }
    }

    private static void duplicateRule(List<Webinar_Member__c> newList){
        for(Webinar_Member__c member : newList){
            List<Webinar_Member__c> duplicate=[SELECT User__c, Contact__c FROM Webinar_Member__c WHERE Contact__c=:member.Contact__c OR User__c=:member.User__c];
            if(duplicate.size()>0){
                member.addError('Two Webinar members cannot be created with the same related user/contact.');
            }
        }
    }
    }