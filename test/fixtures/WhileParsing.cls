public class WhileParsing {
    public void whileMethod(Integer i) {
        do {
            System.debug(i);
            i++;
        } while (i <= 10)
    }

    public void whileMethod2(Integer l) {
        while (l >= 5) {
            System.debug(l);
            l--;
        }
    }
}
