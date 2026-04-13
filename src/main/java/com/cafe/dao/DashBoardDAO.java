package com.cafe.dao;

import com.cafe.dto.TopDrinkDTO;
import java.util.List;

public interface DashBoardDAO {

    List<TopDrinkDTO> getTop5Drinks();
    List<Object[]> getRevenueByDate(int days);
}