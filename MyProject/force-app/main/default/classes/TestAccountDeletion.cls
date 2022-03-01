/**
 * Created by rashimi on 3/1/2022.
 */
@IsTest
public with sharing class TestAccountDeletion {

    @IsTest
    public static void TestDeleteAccountWithOpportunity(){
        Account acc = TestDataFactory.createTestAccount();
        Opportunity opp = TestDataFactory.createTestOpportunity(acc);

        test.startTest();
        Database.DeleteResult result = Database.delete(acc, false);
        test.stopTest();

        System.assert(!result.isSuccess());
        system.assert(result.getErrors().size()>0);
        system.assertEquals('Cannot delete account with related opportunities', result.getErrors()[0].getMessage());
    }
}