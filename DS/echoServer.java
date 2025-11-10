import java.io.*;
import java.net.*;

public class echoServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serversocket = new ServerSocket(4444);
        System.out.println("Listening at port 4444");

        int clientNo = 0;

        while (true) {
            Socket clientSocket = serversocket.accept();
            clientNo++;
            int currentClientNo = clientNo;
            System.out.println("Client " + currentClientNo + " connected successfully.");

            Thread clientThread = new Thread(() -> {
                try {
                    InputStream input = clientSocket.getInputStream();
                    BufferedReader reader = new BufferedReader(new InputStreamReader(input));

                    OutputStream output = clientSocket.getOutputStream();
                    PrintWriter writer = new PrintWriter(output, true);

                    writer.println("Client " + currentClientNo + " connected to server successfully");

                    String clientMessage;
                    while ((clientMessage = reader.readLine()) != null) {
                        System.out.println("Client " + (currentClientNo) + " says: " + clientMessage);
                        writer.println("Hello Client " + (currentClientNo) + " , I received: " + clientMessage);
                    }

                    System.out.println("Client " + (currentClientNo) + " disconnected.");
                    clientSocket.close();

                } catch (IOException e) {
                    System.out.println("Error : " + e.getMessage());
                }
            });
            clientThread.start();
        }
    }
}