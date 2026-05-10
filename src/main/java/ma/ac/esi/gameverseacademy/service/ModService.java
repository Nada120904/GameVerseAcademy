package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.mod;
import ma.ac.esi.gameverseacademy.repository.ModRepository;
import java.util.ArrayList;
import java.util.List;

public class ModService {

    private ModRepository modRepository = new ModRepository();

    public List<mod> getAllMods() {
        return modRepository.getAllMods();
    }

    public mod getModById(int id) {
        return modRepository.getModById(id);
    }

    public List<mod> getModsByCategory(String category) {
        List<mod> all = modRepository.getAllMods();
        List<mod> filtered = new ArrayList<>();
        for (mod mod : all) {
            if (mod.getCategory() != null &&
                mod.getCategory().equalsIgnoreCase(category)) {
                filtered.add(mod);
            }
        }
        return filtered;
    }

    public boolean submitMod(mod m) {
        if (m.getTitle() == null || m.getTitle().trim().isEmpty()) {
            return false;
        }
        return modRepository.insertMod(m); 
}
    
}


    