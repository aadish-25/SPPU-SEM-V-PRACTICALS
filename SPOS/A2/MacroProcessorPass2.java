import java.util.*;

public class MacroProcessorPass2 {

    public static List<String> expandMacros(MacroProcessorPass1.Result pass1Result) {
        Map<String, Integer> MNT = pass1Result.MNT;
        List<String> MDT = pass1Result.MDT;
        List<String> intermediate = pass1Result.intermediateCode;

        List<String> output = new ArrayList<>();

        for (String line : intermediate) {
            String[] parts = line.split("\\s+", 2);
            String mnemonic = parts[0];

            if (MNT.containsKey(mnemonic)) {
                String[] actualArgs = (parts.length > 1) ? parts[1].split(",") : new String[0];
                int mdtIndex = MNT.get(mnemonic);

                // Get prototype line from MDT
                String prototype = MDT.get(mdtIndex);
                String[] protoParts = prototype.split("\\s+", 2);
                String[] formalArgs = (protoParts.length > 1) ? protoParts[1].split(",") : new String[0];

                mdtIndex++; // Start of macro body
                while (!MDT.get(mdtIndex).equals("MEND")) {
                    String expanded = MDT.get(mdtIndex);
                    for (int i = 0; i < formalArgs.length; i++) {
                        expanded = expanded.replace(formalArgs[i].trim(), actualArgs[i].trim());
                    }
                    output.add(expanded);
                    mdtIndex++;
                }
            } else {
                output.add(line); // Not a macro call
            }
        }

        return output;
    }
}
