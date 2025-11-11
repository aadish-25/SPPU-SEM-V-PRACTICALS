import java.util.*;

public class Pass1 {
    private Map<String, Integer> optab;
    private Map<String, Integer> symtab;
    private List<String> intermediateCode;
    private int locctr;

    public Pass1() {
        optab = new HashMap<>();
        symtab = new LinkedHashMap<>();
        intermediateCode = new ArrayList<>();
        locctr = 0;

        // Opcodes
        optab.put("MOVER", 1);
        optab.put("ADD", 1);
        optab.put("SUB", 1);
    }

    public void runFromString(String[] asmCode) {
        boolean started = false;

        for (String line : asmCode) {
            line = line.trim();
            if (line.isEmpty() || line.startsWith(";")) continue;

            String[] tokens = line.split("\\s+");
            String label = "";
            String opcode = "";
            String operand = "";

            if (tokens.length == 3) {
                label = tokens[0];
                opcode = tokens[1].toUpperCase();
                operand = tokens[2];
            } else if (tokens.length == 2) {
                opcode = tokens[0].toUpperCase();
                operand = tokens[1];
            } else if (tokens.length == 1) {
                opcode = tokens[0].toUpperCase();
            } else {
                System.out.println("Invalid line: " + line);
                continue;
            }

            if (opcode.equals("START")) {
                locctr = Integer.parseInt(operand);
                intermediateCode.add(locctr + "\t(AD,01)\t" + operand);
                started = true;
                continue;
            }

            if (!started) {
                System.out.println("Program must start with START directive.");
                break;
            }

            if (!label.isEmpty()) {
                if (symtab.containsKey(label)) {
                    System.out.println("Error: Duplicate symbol " + label);
                } else {
                    symtab.put(label, locctr);
                }
            }

            if (optab.containsKey(opcode)) {
                intermediateCode.add(locctr + "\t(IS," + getOpCodeNumber(opcode) + ")\t" + operand);
                locctr += optab.get(opcode);

            } else if (opcode.equals("DC")) {
                intermediateCode.add(locctr + "\t(DL,01)\t" + operand);
                locctr += 1;

            } else if (opcode.equals("DS")) {
                intermediateCode.add(locctr + "\t(DL,02)\t" + operand);
                locctr += Integer.parseInt(operand);

            } else if (opcode.equals("END")) {
                intermediateCode.add(locctr + "\t(AD,02)");
                break;

            } else {
                System.out.println("Invalid opcode: " + opcode);
            }
        }
    }

    public Map<String, Integer> getSymbolTable() {
        return symtab;
    }

    public List<String> getIntermediateCode() {
        return intermediateCode;
    }

    private int getOpCodeNumber(String opcode) {
        switch (opcode) {
            case "MOVER": return 1;
            case "ADD": return 2;
            case "SUB": return 3;
            default: return 0;
        }
    }
}
