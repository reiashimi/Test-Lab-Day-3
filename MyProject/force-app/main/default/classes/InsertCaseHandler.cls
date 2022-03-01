/**
 * Created by rashimi on 3/1/2022.
 */

public with sharing class InsertCaseHandler {
    public static void updateCase (Case caseC) {
        if (caseC.Status == 'Open')
            caseC.Priority = 'Low';
        else caseC.Priority = 'Medium';
    }

}