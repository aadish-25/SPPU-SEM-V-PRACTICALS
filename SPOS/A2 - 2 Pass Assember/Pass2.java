import java.util.*;

public class Pass2 {
    private List<String> machineCode;

    public Pass2() {
        machineCode = new ArrayList<>();
    }

    public void run(List<String> intermediateCode, Map<String, Integer> symtab) {
        for (String line : intermediateCode) {
            line = line.trim();
            if (line.isEmpty())
                continue;

            String[] parts = line.split("\t");
            int loc = Integer.parseInt(parts[0]);
            String code = parts[1]; // (IS,1), (DL,01), etc.
            String operand = parts.length > 2 ? parts[2] : "";

            String cleanCode = code.replace("(", "").replace(")", "");
            String[] codeParts = cleanCode.split(",");

            String type = codeParts[0];
            int opcode = Integer.parseInt(codeParts[1]);

            if (type.equals("IS")) {
                // Operand is a symbol or constant
                int opAddr = 0;
                if (!operand.isEmpty()) {
                    String[] ops = operand.split(",");
                    String sym = ops.length > 1 ? ops[1] : ops[0];
                    if (symtab.containsKey(sym)) {
                        opAddr = symtab.get(sym);
                    } else {
                        try {
                            opAddr = Integer.parseInt(sym);
                        } catch (NumberFormatException e) {
                            System.out.println("Undefined symbol: " + sym);
                        }
                    }
                }
                machineCode.add(loc + "\t" + opcode + "\t" + opAddr);

            } else if (type.equals("DL")) {
                if (opcode == 1) { // DC
                    machineCode.add(loc + "\t00\t" + operand);
                } else if (opcode == 2) { // DS (reserve)
                    int size = Integer.parseInt(operand);
                    for (int i = 0; i < size; i++) {
                        machineCode.add((loc + i) + "\t00\t0");
                    }
                }

            } // Ignore AD type, no machine code generated
        }
    }

    public List<String> getMachineCode() {
        return machineCode;
    }
}