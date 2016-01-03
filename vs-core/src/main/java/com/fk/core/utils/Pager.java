package com.fk.core.utils;

/**
 * 工具类--表格分页对象
 * 基于 bootstrap-table 插件使用
 */
public class Pager {

    private String search; // 搜索内容
    private String sort;   // 排序的列
    private String order;  // 正序逆序
    private Integer limit; // 每页数据
    private Integer offset;// 偏移数据
    private Long totalRows;// 数据总数

    public Pager() {
    }

    public Pager(String search, String sort, String order, Integer limit, Integer offset, Long totalRows) {
        this.search = search;
        this.sort = sort;
        this.order = order;
        this.limit = limit;
        this.offset = offset;
        this.totalRows = totalRows;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Long getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Long totalRows) {
        this.totalRows = totalRows;
    }
}
