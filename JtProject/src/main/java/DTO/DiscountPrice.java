package DTO;

public class DiscountPrice {
    public int productid;
    public int oldprice;
    public int newprice;

    public int getOldprice() {
        return oldprice;
    }

    public void setOldprice(int oldprice) {
        this.oldprice = oldprice;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getNewprice() {
        return newprice;
    }

    public void setNewprice(int newprice) {
        this.newprice = newprice;
    }
}
