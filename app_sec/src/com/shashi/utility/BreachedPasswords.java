package com.shashi.utility;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BreachedPasswords {
    private List<String> commonBreachedPasswords;

    public BreachedPasswords() {
        commonBreachedPasswords = new ArrayList<>();
        readBreachedPasswordsFromFile("./src/com/shashi/utility/file.txt");
    }

    private void readBreachedPasswordsFromFile(String filename) {
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Assuming each password is on a separate line in the file
                commonBreachedPasswords.add(line.trim());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(commonBreachedPasswords);
    }

    public boolean isPasswordBreached(String password) {
        return commonBreachedPasswords.contains(password);
    }
}
