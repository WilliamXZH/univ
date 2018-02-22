package pers.william.chat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;
import java.util.ArrayList;

public class ChatServer {

    public List<Socket> clients = new ArrayList<Socket>();

    public static void main(String[] args) throws IOException {
        new ChatServer().startServer();
    }

    private void startServer() {
        ServerSocket server;
        try {
            server = new ServerSocket(12345);
            while (true) {
                System.out.println("waiting...");
                Socket s = server.accept();
                clients.add(s);
                this.new ClientThread(s).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public class ClientThread extends Thread {

        Socket s;
        BufferedReader in;

        public ClientThread(Socket client) {
            s = client;
            try {
                in = new BufferedReader(new InputStreamReader(s.getInputStream(), "utf-8"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public void run() {
            try {
                String sentence = null;
                while ((sentence = in.readLine()) != null) {
                    for (Socket s : clients) {
                        try {
                            s.getOutputStream().write(
                                (sentence + "\n").getBytes("utf-8"));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
