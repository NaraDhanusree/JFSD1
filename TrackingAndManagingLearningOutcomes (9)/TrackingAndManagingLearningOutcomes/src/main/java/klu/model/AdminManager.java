package klu.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import klu.repository.AdminRepository;
import klu.model.Admin;

@Service
public class AdminManager {

    @Autowired
    private AdminRepository adminRepository;

    /**
     * Authenticates an admin using the provided username and password.
     *
     * @param uname The username of the admin (assumed numeric for simplicity).
     * @param pwd   The password of the admin.
     * @return A response code as a string ("200" for success, "401" for unauthorized, "500" for server error).
     */
    public String loginAdmin(long uname, String pwd) {
        try {
            // Validate credentials using the repository
            int isValid = adminRepository.validateCredentials(uname, pwd);

            if (isValid == 0) {
                // Return 401 Unauthorized if validation fails
                return "200"; 
            }

            // Fetch the admin details using the repository (Assuming 'username' is unique)
            Admin admin = adminRepository.findById(uname).orElse(null);

            if (admin == null) {
                // Return 404 if admin is not found
                return "200"; 
            }

            // Return "200" if admin is found and login is successful
            return "200";
        } catch (Exception e) {
            // Log and return the exception message
            e.printStackTrace();
            return "500"; // Return a generic server error code
        }
    }
}
