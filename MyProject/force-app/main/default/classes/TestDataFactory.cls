/**
 * Created by rashimi on 3/1/2022.
 */
@IsTest
public with sharing class TestDataFactory {

    public static Account createTestAccount(){
        return createTestAccount(true);
    }

    private static Account createTestAccount(Boolean doInsert){
        Account acc = new Account(Name = 'Test Account 1');

        if(doInsert){
            insert acc;
        }

        return acc;
    }


    public static Opportunity createTestOpportunity(Account acc){
        return createTestOpportunity(acc,true);
    }

    private static Opportunity createTestOpportunity(Account acc, Boolean doInsert){
        Opportunity opp = new Opportunity(Name = 'Test Account 1',
                CloseDate=System.today().addMonths(1),
                StageName = 'Prospecting',
                AccountId = acc.Id);

        if(doInsert){
            insert opp;
        }

        return opp;
    }


    public static Case createTestCase(String status, String prio){
        return createTestCase(status,true, prio);
    }

    private static Case createTestCase(String status, Boolean doInsert, String prio){
        Case c = new Case(Status = status,
                Origin = 'Email',
                Priority = prio);

        if(doInsert){
            insert c;
        }

        return c;
    }

}