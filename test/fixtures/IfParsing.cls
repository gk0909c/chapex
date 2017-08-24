public class IfParsing {
    public void ifMethod(String def) {
        String abc = 'def';
        if (abc == def) {
            String a = abc.substring(1, 3);
            System.debug(a);
        } else if (def.exists()) {
            System.debug('do else if');
        } else {
            System.debug('do else');
        }
    }
}
