package hps.dao;

import hps.dto.Consignment;
import hps.dto.Customer;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

/**
 *
 * @author Phuc Tran
 */
public class InMemoryCustomerDAO implements CustomerDAO {
    
    private Map<Long, Customer> database = new LinkedHashMap<>();
    private AtomicLong preId = new AtomicLong();

    @Override
    public void save(Customer customer) {
        if (customer.getId() == null) {
            customer.setId(preId.incrementAndGet());
        }
        database.put(customer.getId(), customer);
    }

    @Override
    public Customer get(long id) {
        return database.get(id);
    }

    @Override
    public void delete(long id) {
        database.remove(id);
    }    
}
