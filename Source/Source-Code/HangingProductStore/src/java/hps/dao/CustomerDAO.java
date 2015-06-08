package hps.dao;

import hps.dto.Consignment;
import hps.dto.Customer;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public interface CustomerDAO {
    void save(Customer customer);
    Customer get(long id);
    void delete(long id);
}
