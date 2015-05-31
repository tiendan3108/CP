package hps.dto;

import java.util.Date;

/**
 *
 * @author Phuc Tran
 */
public enum ConsignmentStatus {
    REQUEST {
        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getImportDate() != null) {
                return false;
            }
            return true;
        }

        @Override
        public void setStatus(Consignment consignment) {
            return;
        }
    },
    VIEWED {

        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getViewDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setViewDate(new Date());
        }
    },
    ACCEPTED {

        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getAcceptDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setAcceptDate(new Date());
        }
    },
    REFUSED {

        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getRefuseDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setRefuseDate(new Date());
        }
    },
    CANCELED {

        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getCanceledDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setCanceledDate(new Date());
        }
    },
    TRANSFER {

        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getTransferDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setTransferDate(new Date());
        }
    },
    IMPORTED {
        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getImportDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setImportDate(new Date());
        }
    }, SOLD {
        @Override
        public boolean inStatus(Consignment consignment) {
            if (consignment.getSellDate() != null) {
                return true;
            }
            return false;
        }

        @Override
        public void setStatus(Consignment consignment) {
            consignment.setSellDate(new Date());
        }
    };
    public abstract boolean inStatus(Consignment consignment);
    public abstract void setStatus(Consignment consignment);
}
