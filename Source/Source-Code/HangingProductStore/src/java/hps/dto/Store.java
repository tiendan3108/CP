package hps.dto;

import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Phuc Tran
 */
public class Store {
    private Long id;
    private String name;
    private String address;
    private String description;
    
    private List<Consignment> consignments;

    public Store() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Consignment> getConsignments() {
        return consignments;
    }

    public void setConsignments(List<Consignment> consignments) {
        this.consignments = consignments;
    }
    
    public void addConsignment(Consignment consignment) {
        if (this.consignments == null) {
            this.consignments = new LinkedList<>();
        }
        this.consignments.add(consignment);
    }
}
