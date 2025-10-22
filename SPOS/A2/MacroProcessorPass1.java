import java.util.*;

public class MacroProcessorPass1 {

    public static class Result {
        public Map<String, Integer> MNT;
        public List<String> MDT;
        public List<String> intermediateCode;

        public Result(Map<String, Integer> MNT, List<String> MDT, List<String> intermediateCode) {
            this.MNT = MNT;
            this.MDT = MDT;
            this.intermediateCode = intermediateCode;
        }
    }

    public static Result process(String macroCode) {
        Map<String, Integer> MNT = new LinkedHashMap<>();
        List<String> MDT = new ArrayList<>();
        List<String> intermediate = new ArrayList<>();

        String[] lines = macroCode.split("\\r?\\n");
        boolean inMacro = false;
        String macroName = null;

        for (int i = 0; i < lines.length; i++) {
            String line = lines[i].trim();
            if (line.equalsIgnoreCase("MACRO")) {
                inMacro = true;
                // Next line will be macro prototype
                i++;
                line = lines[i].trim();
                macroName = line.split(" ")[0];
                MNT.put(macroName, MDT.size());
                MDT.add(line); // store prototype
                continue;
            }

            if (line.equalsIgnoreCase("MEND")) {
                MDT.add("MEND");
                inMacro = false;
                continue;
            }

            if (inMacro) {
                MDT.add(line);
            } else {
                intermediate.add(line);
            }
        }

        return new Result(MNT, MDT, intermediate);
    }
}
