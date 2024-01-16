package com.shashi.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;

import com.shashi.beans.UserBean;
import com.shashi.constants.IUserConstants;
import com.shashi.service.UserService;
import com.shashi.srv.RegisterSrv;
import com.shashi.utility.DBUtil;

import org.mindrot.jbcrypt.BCrypt;

import com.shashi.utility.KeyManager;

public class UserServiceImpl implements UserService {

	@Override
	public String registerUser(String userName, String mobileNo, String emailId, String address, String pinCode,
			String password, String Salt) {

		UserBean user = new UserBean(userName, mobileNo, emailId, address, pinCode, password, Salt);

		String status = registerUser(user);

		return status;
	}

	@Override
	public String registerUser(UserBean user) {

		String status = "User Registration Failed!";

		boolean isRegtd = isRegistered(user.getEmail());

		// String myStr = " Hello World! ";
		// System.out.println(myStr);
		// System.out.println(myStr.trim());

		if (isRegtd) {
			status = "Email Id Already Registered!";
			return status;
		}
		Connection conn = DBUtil.provideConnection();
		PreparedStatement ps = null;
		if (conn != null) {
			System.out.println("Connected Successfully!");
		}

		String possibleSpacesPassword = user.getPassword();
		String noSpacesPassword = possibleSpacesPassword.trim().replaceAll(" +", " ");

		try {

			if (possibleSpacesPassword.length() < 12) {
				status = "Words in passord truncated made the password with less than 12 characters!";
				System.exit(0);
			}

			ps = conn.prepareStatement("insert into " + IUserConstants.TABLE_USER + " values(?,?,?,?,?,?,?)");

			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setString(3, user.getMobile());
			ps.setString(4, user.getAddress());
			ps.setString(5, user.getPinCode());
			ps.setString(6, noSpacesPassword);
			ps.setString(7, user.getSalt());

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "User Registered Successfully!";
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(ps);

		return status;
	}

	@Override
	public boolean isRegistered(String emailId) {
		boolean flag = false;

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=?");

			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next())
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);

		return flag;
	}

	@Override
	public String isValidCredential(String emailId, String password) {
		String status = "Please input the correct login data";
		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			String sql = "SELECT * FROM user WHERE email = ?";
			ps = con.prepareStatement(sql);

			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next()) {
				String hashedPasswordFromDB = rs.getString("password_hash"); // Recupere o hash da senha do banco de
																				// dados
				if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
					status = "valid"; // Senha está correta
				} else {
					status = "Login Denied! Incorrect Username or Password"; // Senha incorreta
				}
			} else {
				status = "Login Denied! Incorrect Username or Password"; // Usuário não encontrado
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);
		return status;
	}

	@Override
	public UserBean getUserDetails(String emailId, String password) {

		UserBean user = null;

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=?");
			ps.setString(1, emailId);
			rs = ps.executeQuery();

			if (rs.next()) {
				user = new UserBean();
				user.setName(rs.getString("name"));
				user.setMobile(KeyManager.decrypt(rs.getString("mobile"), KeyManager.getSecretKey()));
				user.setEmail(rs.getString("email"));
				user.setAddress(KeyManager.decrypt(rs.getString("address"), KeyManager.getSecretKey()));
				user.setPinCode(KeyManager.decrypt(rs.getString("pincode"), KeyManager.getSecretKey()));
				user.setPassword(rs.getString("password_hash"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBUtil.closeConnection(con);
		DBUtil.closeConnection(ps);
		DBUtil.closeConnection(rs);

		return user;
	}

	@Override
	public String getFName(String emailId) {
		String fname = "";

		Connection con = DBUtil.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select name from user where email=?");
			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next()) {
				fname = rs.getString(1);

				fname = fname.split(" ")[0];

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return fname;
	}

	@Override
	public String getUserAddr(String userId) {
		String userAddr = "";

		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select address from user where email=?");

			ps.setString(1, userId);

			rs = ps.executeQuery();

			if (rs.next())
				userAddr = rs.getString(1);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return userAddr;
	}

	@Override
	public void updateUser(UserBean user) {
		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement(
					"UPDATE user SET name=?, mobile=?, address=?, pincode=?, password=? WHERE email=?");

			ps.setString(1, user.getName());
			ps.setString(2, user.getMobile());
			ps.setString(3, user.getAddress());
			ps.setString(4, user.getPinCode());
			ps.setString(5, user.getPassword());
			ps.setString(6, user.getEmail());

			int rowsUpdated = ps.executeUpdate();

			if (rowsUpdated > 0) {
				System.out.println("User details updated successfully!");
			} else {
				System.out.println("Failed to update user details!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.closeConnection(con);
			DBUtil.closeConnection(ps);
		}
	}

	@Override
	public void deleteUser(String userName) {
		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;
		try {
			ps = con.prepareStatement("DELETE FROM user WHERE name=?");
			ps.setString(1, userName);

			int rowsDeleted = ps.executeUpdate();

			if (rowsDeleted > 0) {
				System.out.println("User deleted successfully!");
			} else {
				System.out.println("Failed to delete user!");
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.closeConnection(con);
			DBUtil.closeConnection(ps);
		}
	}

		
	public void removeUser(UserBean user) {
		Connection con = DBUtil.provideConnection();
		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("DELETE FROM user WHERE email=?");
			ps.setString(1, user.getEmail());

			int rowsDeleted = ps.executeUpdate();

			if (rowsDeleted > 0) {
				System.out.println("User deleted successfully!");
			} else {
				System.out.println("No user found with the given email.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.closeConnection(con);
			DBUtil.closeConnection(ps);
		}
	}

}
