package hps.dao;

import hps.dto.Store;

/**
 *
 * @author Phuc Tran
 */
public interface StoreDAO {
    void save(Store store);
    Store get(long id);
    void delete(long id);
}
