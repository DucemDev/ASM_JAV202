package com.cafe.dao;

import com.cafe.dto.TopDrinkDTO;
import java.util.List;

public interface DashBoardDAO {

    // ===== TOP DRINK =====
    List<TopDrinkDTO> getTop5Drinks();

    // ===== REVENUE CHART =====
    List<Object[]> getRevenueByDate(int days);

    // ===== DASHBOARD STATS =====
    int getTotalRevenue(String from, String to);

    int getTodayRevenue();

    int getBillCount(String from, String to);

    int getUsingTables();
}