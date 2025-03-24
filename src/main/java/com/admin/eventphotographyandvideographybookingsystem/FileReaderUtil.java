package com.admin.eventphotographyandvideographybookingsystem;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class FileReaderUtil {

    public static Admin getAdminCredentials(String filePath, String inputEmail, String inputPassword) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                if (credentials.length == 3){
                    String userName = credentials[0].trim();
                    String email = credentials[1].trim();
                    String password = credentials[2].trim();

                    // Check if email and password match
                    if (email.equalsIgnoreCase(inputEmail) && password.equals(inputPassword)) {
                        return new Admin(userName , email, password);
                    }
                }
            }
        }
        return null; // Return null if no match is found
    }
}
