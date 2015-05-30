package hps.dao;

import hps.dto.Consignment;
import hps.dto.Customer;
import hps.dto.ProductDTO;
import hps.dto.Store;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

/**
 *
 * @author Phuc Tran
 */
public class InMemoryConsignmentDAO implements ConsignmentDAO {
    
    private Map<Long, Consignment> database = new LinkedHashMap<>();
    private AtomicLong preId = new AtomicLong();

    public InMemoryConsignmentDAO() {
    }

    @Override
    public void save(Consignment consignment) {
        if (consignment.getId() == null) {
            consignment.setId(preId.incrementAndGet());
        }
        database.put(consignment.getId(), consignment);
    }

    @Override
    public Consignment get(long id) {
        return database.get(id);
    }

    @Override
    public void delete(long id) {
        database.remove(id);
    }

    @Override
    public int getNonViewRequest(long storeId) {
        int nonViewRequest = 0;
        for (Consignment c : database.values()) {
            if (c.getStore() != null &&
                    c.getStore().getId() == storeId &&
                    c.getViewDate() == null) {
                nonViewRequest++;
            }
        }
        return nonViewRequest;
    }

    @Override
    public List<Consignment> getConsigmentsByStore(long storeId) {
        List<Consignment> consignments = new LinkedList<>();
        for (Consignment c : database.values()) {
            if (c.getStore() != null &&
                    c.getStore().getId() == storeId) {
                consignments.add(c);
            }
        }
        return Collections.unmodifiableList(consignments);
    }

    @Override
    public List<Consignment> getConsigmentsByCustomer(long customerId) {
        List<Consignment> consignments = new LinkedList<>();
        for (Consignment c : database.values()) {
            if (c.getCustomer() != null &&
                    c.getCustomer().getId() == customerId) {
                consignments.add(c);
            }
        }
        return Collections.unmodifiableList(consignments);
    }

    @Override
    public void makeConsignmentAsViewed(long id) {
        Consignment c = database.get(id);
        if (c != null) {
            c.setViewDate(new Date());
        }
    }

    @Override
    public void makeConsignmentAsAccepted(long id) {
        Consignment c = database.get(id);
        if (c != null) {
            c.setAcceptDate(new Date());
        }
    }

    @Override
    public void makeConsignmentAsRefused(long id) {
        Consignment c = database.get(id);
        if (c != null) {
            c.setRefuseDate(new Date());
        }
    }

    @Override
    public void makeConsignmentAsTransfered(long id) {
        Consignment c = database.get(id);
        if (c != null) {
            c.setTransferDate(new Date());
        }
    }

    @Override
    public void makeConsignmentAsCanceled(long id) {
        Consignment c = database.get(id);
        if (c != null) {
            c.setCanceledDate(new Date());
        }
    }
    
}
