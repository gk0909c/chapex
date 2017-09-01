public with sharing class Leo {
    public final static String CONST_VAL = 'TEST';
    private String str2;
    Integer int1;

    public void getMethod1() {
        String message = 'abbb';
        System.debug(message);
        str2 = message;
        System.debug(str2);

        List<Obj__c> list = [SELECT
                                Id, Name,
                            FROM
                                Obj__c];
    }
}
