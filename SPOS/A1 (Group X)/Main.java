public class Main {
    public static void main(String[] args) {
        String[] asmCode = {
            "START 100",
            "MOVER AREG,ONE",
            "ADD BREG,TWO",
            "LOOP SUB CREG,THREE",
            "ONE DC 1",
            "TWO DC 2",
            "THREE DC 3",
            "END"
        };

        Pass1 pass1 = new Pass1();
        pass1.runFromString(asmCode);

        System.out.println("Intermediate Code:");
        pass1.getIntermediateCode().forEach(System.out::println);

        System.out.println("\nSymbol Table:");
        pass1.getSymbolTable().forEach((k,v) -> System.out.println(k + "\t" + v));

        Pass2 pass2 = new Pass2();
        pass2.run(pass1.getIntermediateCode(), pass1.getSymbolTable());

        System.out.println("\nMachine Code:");
        pass2.getMachineCode().forEach(System.out::println);
    }
}
