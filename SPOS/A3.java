/*
0 - A3.c in the same directory as A3.java 
0 - sudo apt install openjdk-21-jdk

1 - javac A3.java
2 - javac -h . A3.java
3 - JAVA_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
    gcc -shared -fPIC -o libA3.so \
    -I"$JAVA_PATH/include" \
    -I"$JAVA_PATH/include/linux" \
    A3.c
4 - java -Djava.library.path=. A3
*/

import java.util.*;

class A3 {
    static {
        System.loadLibrary("A3");
    }

    // Native method declarations
    private native int add(int a, int b);
    private native int sub(int a, int b);
    private native int mul(int a, int b);
    private native int div(int a, int b);

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a, b, choice;

        System.out.print("\nValue of a:\t");
        a = sc.nextInt();

        System.out.print("\nValue of b:\t");
        b = sc.nextInt();

        while (true) {
            System.out.println("\n----- MAIN MENU -----");
            System.out.println("1 -> Addition");
            System.out.println("2 -> Subtraction");
            System.out.println("3 -> Multiplication");
            System.out.println("4 -> Division");
            System.out.println("5 -> Exit");
            System.out.print("Choose an option:\t");

            choice = sc.nextInt();
            A3 obj = new A3();

            switch (choice) {
                case 1:
                    System.out.println("Result: " + obj.add(a, b));
                    break;
                case 2:
                    System.out.println("Result: " + obj.sub(a, b));
                    break;
                case 3:
                    System.out.println("Result: " + obj.mul(a, b));
                    break;
                case 4:
                    System.out.println("Result: " + obj.div(a, b));
                    break;
                case 5:
                    System.out.println("Exiting...");
                    System.exit(0);
                default:
                    System.out.println("Please choose a valid option.");
                    break;
            }
        }
    }
}
