package com.qf.oa.entity;

public class MyCount {

    private String dname;
    private String count;

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "MyCount{" +
                "dname='" + dname + '\'' +
                ", count='" + count + '\'' +
                '}';
    }
}
