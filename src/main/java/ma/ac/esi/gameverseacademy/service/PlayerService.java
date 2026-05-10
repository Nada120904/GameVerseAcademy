package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Player;
import ma.ac.esi.gameverseacademy.repository.PlayerRepository;
import java.util.List;

public class PlayerService {

    private PlayerRepository playerRepository = new PlayerRepository();

    public List<Player> getAllPlayers() {
        return playerRepository.getAllPlayers();
    }

    public Player getPlayerById(int id) {
        return playerRepository.getPlayerById(id);
    }

    public boolean addPlayer(Player player) {
        if (player.getUsername() == null || player.getUsername().trim().isEmpty()) {
            return false;
        }
        return playerRepository.insertPlayer(player);
    }

    public boolean updatePlayer(Player player) {
        if (player.getUsername() == null || player.getUsername().trim().isEmpty()) {
            return false;
        }
        return playerRepository.updatePlayer(player);
    }

    public boolean deletePlayer(int id) {
        return playerRepository.deletePlayer(id);
    }
}