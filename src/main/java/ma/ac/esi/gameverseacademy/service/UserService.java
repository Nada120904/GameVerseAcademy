package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.repository.UserRepository;

public class UserService {
	
	
	private final UserRepository userRepository;
	
	
	public UserService() {
		super();
		this.userRepository = new UserRepository();
	}


	

	public boolean finUserByCredentials(String login, String password)
	{
		return userRepository.userExists(login, password);
		
	}
	
	public boolean authenticateUser(String login, String password) {
	    return userRepository.userExists(login, password);
	}

}
