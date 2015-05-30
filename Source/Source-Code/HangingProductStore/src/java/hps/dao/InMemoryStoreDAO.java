package hps.dao;

import hps.dto.Store;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

/**
 *
 * @author Phuc Tran
 */
public class InMemoryStoreDAO implements StoreDAO {
    
    private Map<Long, Store> database = new LinkedHashMap<>();
    private AtomicLong preId = new AtomicLong();

    public InMemoryStoreDAO() {
    }

    @Override
    public void save(Store store) {
        if (store.getId() == null) {
            store.setId(preId.incrementAndGet());
        }
        database.put(store.getId(), store);
    }

    @Override
    public Store get(long id) {
        return database.get(id);
    }

    @Override
    public void delete(long id) {
        database.remove(id);
    }
    
}
