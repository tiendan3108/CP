/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hps.dto;

/**
 *
 * @author Tien Dan
 */
public class SeasonDTO {
    private int seasonID;
    private String seasonName;

    public SeasonDTO() {
    }

    public SeasonDTO(int seasonID, String seasonName) {
        this.seasonID = seasonID;
        this.seasonName = seasonName;
    }

    /**
     * @return the seasonID
     */
    public int getSeasonID() {
        return seasonID;
    }

    /**
     * @param seasonID the seasonID to set
     */
    public void setSeasonID(int seasonID) {
        this.seasonID = seasonID;
    }

    /**
     * @return the seasonName
     */
    public String getSeasonName() {
        return seasonName;
    }

    /**
     * @param seasonName the seasonName to set
     */
    public void setSeasonName(String seasonName) {
        this.seasonName = seasonName;
    }
    
}
