// Design suitable data structures and implement Pass-I and Pass-II of a two-pass macroprocessor. The output of Pass-I (MNT, MDT and intermediate code file without any macro
// definitions) should be input for Pass-II.

// Pass 1 Assembler - Study the assembly code and build tables: MNT, MDT, Symbol Table
// Pass 2 Assembler - Expand macro calls using the tables and generate final machine code

import java.util.*;

public class Main {
    public static void main(String[] args) {
        String macroInput = """
                MACRO
                INCR &A
                LOAD &A
                ADD 1
                STORE &A
                MEND
                START
                INCR X
                INCR Y
                END
                """;

        // Pass-I
        MacroProcessorPass1.Result pass1Result = MacroProcessorPass1.process(macroInput);

        // Debug: Print MNT
        System.out.println("Macro Name Table (MNT):");
        for (Map.Entry<String, Integer> entry : pass1Result.MNT.entrySet()) {
            System.out.println(entry.getKey() + " -> MDT Index: " + entry.getValue());
        }

        // Debug: Print MDT
        System.out.println("\nMacro Definition Table (MDT):");
        for (int i = 0; i < pass1Result.MDT.size(); i++) {
            System.out.println(i + " " + pass1Result.MDT.get(i));
        }

        // Debug: Print Intermediate Code
        System.out.println("\nIntermediate Code:");
        for (String line : pass1Result.intermediateCode) {
            System.out.println(line);
        }

        // Pass-II
        List<String> output = MacroProcessorPass2.expandMacros(pass1Result);

        // Final Output
        System.out.println("\nExpanded Code After Pass-II:");
        for (String line : output) {
            System.out.println(line);
        }
    }
}
