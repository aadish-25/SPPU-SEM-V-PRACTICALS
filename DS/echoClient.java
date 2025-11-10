import java.io.*;
import java.net.*;

public class echoClient {
    public static void main(String[] args) throws IOException{
        Socket socket = new Socket("127.0.0.1", 4444);

        InputStream input = socket.getInputStream();
        OutputStream output = socket.getOutputStream();

        PrintWriter writer = new PrintWriter(output, true);
        BufferedReader reader = new BufferedReader(new InputStreamReader(input));
        BufferedReader userInput = new BufferedReader(new InputStreamReader(System.in));

        String message;
        String welcome = reader.readLine();
        System.out.println(welcome);
        
        while((message = userInput.readLine())!=null){
            writer.println(message);
            String serverResponse = reader.readLine();
            System.out.println("Server : " + serverResponse);
        }

        socket.close();
    }
}