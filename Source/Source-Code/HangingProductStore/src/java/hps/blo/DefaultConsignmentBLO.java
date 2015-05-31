package hps.blo;

import hps.dao.ConsignmentDAO;
import hps.dao.CustomerDAO;
import hps.dao.StoreDAO;
import hps.dto.Consignment;
import hps.dto.ConsignmentStatus;
import hps.dto.Customer;
import hps.dto.ProductDTO;
import hps.dto.Store;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public class DefaultConsignmentBLO implements ConsignmentBLO {

    private final CustomerDAO customerDAO;
    private final ConsignmentDAO consignmentDAO;
    private final StoreDAO storeDAO;

    public DefaultConsignmentBLO(CustomerDAO customerDAO, ConsignmentDAO consignmentDAO, StoreDAO storeDAO) {
        this.customerDAO = customerDAO;
        this.consignmentDAO = consignmentDAO;
        this.storeDAO = storeDAO;
    }

    @Override
    public void saveConsignment(Customer customer, ProductDTO product, Store store, Consignment consignment) {
        if (customer != null) {
            customer.addConsignment(consignment);
            consignment.setCustomer(customer);

            consignment.setCustomerName(customer.getName());
            consignment.setCustomerAddress(customer.getAddress());
            consignment.setCustomerPhone(customer.getPhone());
            
            customerDAO.save(customer);
        }
        store.addConsignment(consignment);
        storeDAO.save(store);
        
        consignment.setStore(store);
        consignment.setProduct(product);
        consignmentDAO.save(consignment);
    }

    @Override
    public Consignment getConsignment(long id) {
        return consignmentDAO.get(id);
    }

    @Override
    public int getNonViewRequest(long storeId) {
        return consignmentDAO.getNonViewRequest(storeId);
    }

    @Override
    public List<Consignment> getConsigmentsByStore(long storeId) {
        return consignmentDAO.getConsigmentsByStore(storeId);
    }

    @Override
    public List<Consignment> getConsigmentsRequest(long storeId) {
        return consignmentDAO.getConsignmentByStatus(storeId, ConsignmentStatus.REQUEST);
    }

    @Override
    public List<Consignment> getConsigmentsImported(long storeId) {
        return consignmentDAO.getConsignmentByStatus(storeId, ConsignmentStatus.IMPORTED);
    }

    @Override
    public List<Consignment> getConsigmentsSold(long storeId) {
        return consignmentDAO.getConsignmentByStatus(storeId, ConsignmentStatus.SOLD);
    }

    @Override
    public List<Consignment> getConsigmentsByCustomer(long customerId) {
        return consignmentDAO.getConsigmentsByCustomer(customerId);
    }

    @Override
    public void makeConsignmentAsViewed(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.VIEWED);
    }

    @Override
    public void makeConsignmentAsAccepted(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.ACCEPTED);
    }

    @Override
    public void makeConsignmentAsRefused(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.REFUSED);
    }

    @Override
    public void makeConsignmentAsTransfered(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.TRANSFER);
    }

    @Override
    public void makeConsignmentAsImported(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.IMPORTED);
    }

    @Override
    public void makeConsignmentAsCanceled(long id) {
        consignmentDAO.makeConsignmentAsStatus(id, ConsignmentStatus.CANCELED);
    }

    @Override
    public List<Customer> getConsignorsByStore(long storeId) {
        List<Customer> consignors = new LinkedList<>();

        List<Consignment> consignments = consignmentDAO.getConsigmentsByStore(storeId);
        for (Consignment c : consignments) {
            if (c.getCustomer() != null) {
                consignors.add(c.getCustomer());
            }
        }

        return consignors;
    }

}
